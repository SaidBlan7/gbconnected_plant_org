package com.gbc.access.service;

public class LakebaseDataApiException extends RuntimeException {

    private final int statusCode;
    private final String responseBody;

    public LakebaseDataApiException(int statusCode, String responseBody) {
        super("Lakebase Data API failed with HTTP " + statusCode);
        this.statusCode = statusCode;
        this.responseBody = responseBody;
    }

    public LakebaseDataApiException(String message, Throwable cause) {
        super(message, cause);
        this.statusCode = 502;
        this.responseBody = null;
    }

    public int getStatusCode() {
        return statusCode;
    }

    public String getResponseBody() {
        return responseBody;
    }
}
