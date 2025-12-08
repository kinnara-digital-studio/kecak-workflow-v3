package org.kecak.apps.scheduler;

import net.sf.ehcache.Cache;
import net.sf.ehcache.Element;
import org.joget.apps.app.dao.AppDefinitionDao;
import org.joget.apps.app.model.AppDefinition;
import org.joget.apps.app.service.AppUtil;
import org.joget.commons.util.LogUtil;
import org.joget.commons.util.StringUtil;
import org.joget.plugin.base.ExtDefaultPlugin;
import org.joget.plugin.base.Plugin;
import org.joget.plugin.base.PluginManager;
import org.joget.plugin.property.service.PropertyUtil;
import org.kecak.apps.app.model.SchedulerPlugin;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.SimpleTrigger;
import org.springframework.context.ApplicationContext;

import java.util.*;
import java.util.function.Supplier;

/**
 * Kecak Exclusive
 *
 * @author aristo
 * <p>
 * Job for Scheduler Plugin
 */
public class SchedulerPluginJob implements Job {
    /**
     * Execute
     *
     * @param context
     * @throws JobExecutionException
     */
    @Override
    public void execute(final JobExecutionContext context) throws JobExecutionException {
        final ApplicationContext applicationContext = AppUtil.getApplicationContext();
        final PluginManager pluginManager = (PluginManager) applicationContext.getBean("pluginManager");
        final AppDefinitionDao appDefinitionDao = (AppDefinitionDao) applicationContext.getBean("appDefinitionDao");
        final boolean manualTrigger = context.getTrigger() instanceof SimpleTrigger; // Triggered from "Fire Now"

        Optional.ofNullable(appDefinitionDao.findPublishedApps(null, null, null, null))
                .stream()
                .flatMap(Collection::stream)

                // set current app definition
                .peek(AppUtil::setCurrentAppDefinition)

                .forEach(appDefinition -> Optional.of(appDefinition)
                        .map(AppDefinition::getPluginDefaultPropertiesList)
                        .stream()
                        .flatMap(Collection::stream)
                        .forEach(pluginDefaultProperty -> Optional.of(pluginDefaultProperty)
                                .map(p -> {
                                    String name = p.getId();
                                    String pluginProperties = p.getPluginProperties();
                                    String cacheKey = String.join("#", appDefinition.getAppId(), String.valueOf(appDefinition.getVersion()), name, StringUtil.md5(pluginProperties));
                                    return getFromCache(cacheKey, () -> {
                                        Plugin plugin = pluginManager.getPlugin(name);

                                        if(plugin instanceof ExtDefaultPlugin) {
                                            Map<String, Object> props = PropertyUtil.getPropertiesValueFromJson(pluginProperties);
                                            ((ExtDefaultPlugin)plugin).setProperties(props);
                                        }

                                        return plugin;
                                    });
                                })
                                .filter(p -> p instanceof SchedulerPlugin && p instanceof ExtDefaultPlugin)
                                .map(p -> (ExtDefaultPlugin) p)
                                .ifPresent(plugin -> {
                                    Map<String, Object> parameterProperties = plugin.getProperties();
                                    parameterProperties.put(SchedulerPlugin.PROPERTY_APP_DEFINITION, appDefinition);
                                    parameterProperties.put(SchedulerPlugin.PROPERTY_PLUGIN_MANAGER, pluginManager);

                                    try {
                                        if (((SchedulerPlugin) plugin).filter(context, parameterProperties) || manualTrigger) {
                                            ((SchedulerPlugin) plugin).jobRun(context, parameterProperties);
                                        } else {
                                            LogUtil.debug(getClass().getName(), "Skipping Scheduler Job Plugin [" + plugin.getName() + "] : Not meeting filter condition");
                                        }
                                    } catch (Exception e) {
                                        ((SchedulerPlugin) plugin).onJobError(context, parameterProperties, e);
                                    }
                                })));
    }

    /**
     * Get From Cache
     *
     * @param key
     * @param whenMissing
     * @return
     * @param <T>
     */
    protected <T> T getFromCache(String key, Supplier<T> whenMissing) {
        assert Objects.nonNull(key);
        assert Objects.nonNull(whenMissing);

        Cache cache = (Cache) AppUtil.getApplicationContext().getBean("schedulerPluginCache");
        Element cached = cache.get(key);
        if (cached != null) {
            T value = (T) cached.getObjectValue();
            LogUtil.debug(getClass().getName(), "Hitting cache [" + cache.getName() + "] key [" + key + "] value [" + value + "]");
            return value;
        }

        LogUtil.debug(getClass().getName(), "Missing cache [" + cache.getName() + "] key [" + key + "]");

        T value = whenMissing.get();
        if(value != null) {
            cache.put(new Element(key, value));
        }

        return value;
    }
}
