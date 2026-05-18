package org.kecak.apps.apiKeys.exception;

public class ApiKeyServiceException extends Exception {
    public ApiKeyServiceException(String message) {
        super(message);
    }

    public ApiKeyServiceException(Throwable cause) {
        super(cause);
    }
}
