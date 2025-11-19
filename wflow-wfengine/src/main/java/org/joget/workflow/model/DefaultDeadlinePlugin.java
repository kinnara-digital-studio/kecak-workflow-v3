package org.joget.workflow.model;

import java.util.Map;

import org.joget.plugin.base.ExtDefaultPlugin;
import org.joget.plugin.base.PluginManager;
import org.joget.workflow.model.service.WorkflowManager;

/**
 * A base abstract class to develop a Deadline Plugin
 * 
 */
public abstract class DefaultDeadlinePlugin extends ExtDefaultPlugin implements DeadlinePlugin {
    
    /**
     * This is not used
     * 
     * @param props
     * @return 
     */
    @Override
    public final Object execute(Map props) {
        return evaluateDeadline(props);
    }

    /**
     * Get current workflow deadline
     *
     * @return
     */
    protected WorkflowDeadline getWorkflowDeadline() {
        return (WorkflowDeadline) getProperty("workflowDeadline");
    }

    /**
     * Get current workflow process
     *
     * @return
     */
    protected WorkflowProcess getWorkflowProcess() {
        PluginManager pluginManager = (PluginManager) getProperty("pluginManager");
        WorkflowManager workflowManager = (WorkflowManager) pluginManager.getBean("workflowManager");
        String processId = String.valueOf(getProperty("processId"));
        return workflowManager.getRunningProcessById(processId);
    }

    /**
     * Get current workflow activity
     *
     * @return
     */
    protected WorkflowActivity getWorkflowActivity() {
        PluginManager pluginManager = (PluginManager) getProperty("pluginManager");
        WorkflowManager workflowManager = (WorkflowManager) pluginManager.getBean("workflowManager");
        String activityId = String.valueOf(getProperty("activityId"));
        return workflowManager.getActivityById(activityId);
    }
}
