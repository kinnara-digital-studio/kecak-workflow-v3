package org.kecak.apps.app.scheduler.model;

/**
 * Kecak Exclusive
 */
public enum JobStatus {

	SUCCESS("Success"), FAIL("Fail");

	private String code;

	private JobStatus(String code) {
		this.code = code;
	}

	public String getCode() {
		return code;
	}
}
