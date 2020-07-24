package org.kecak.apps.property;

import org.springframework.core.io.support.PropertiesLoaderSupport;

import java.util.Properties;

public class SimplePropertiesLoader extends PropertiesLoaderSupport implements PropertiesLoader {

	public Properties loadProperties() {
		try {
			Properties mergeProperties = new Properties();
			mergeProperties = super.mergeProperties();
			return mergeProperties;
		} catch (Exception e) {
			return null;
		}
	}

}
