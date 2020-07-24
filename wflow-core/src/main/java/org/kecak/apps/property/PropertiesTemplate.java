package org.kecak.apps.property;

import org.springframework.core.io.Resource;
import org.springframework.util.CollectionUtils;

import java.io.IOException;
import java.util.Properties;

public class PropertiesTemplate extends Properties {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5035504924418610552L;

	private PropertiesLoader propertiesLoader;
	
	private Resource[] locations;
	
	public void setPropertiesLoader(PropertiesLoader propertiesLoader) throws IOException {
		this.propertiesLoader = propertiesLoader;
		refresh();
	}
	
	public void refresh() throws IOException {
		CollectionUtils.mergePropertiesIntoMap(propertiesLoader.loadProperties(),this);
	}
	
	public void setLocations(Resource[] locations) throws Exception {
		this.locations = locations;
		SimplePropertiesLoader propertiesLoader = new SimplePropertiesLoader();
		propertiesLoader.setLocations(this.locations);
		CollectionUtils.mergePropertiesIntoMap(propertiesLoader.loadProperties(),this);
		
	}
}