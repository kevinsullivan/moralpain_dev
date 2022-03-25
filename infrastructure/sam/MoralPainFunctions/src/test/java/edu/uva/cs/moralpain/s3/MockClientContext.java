package edu.uva.cs.moralpain.s3;

import com.amazonaws.services.lambda.runtime.*;

import java.util.HashMap;
import java.util.Map;

public class MockClientContext implements ClientContext {
    private Map<String, String> environment;

    public MockClientContext() {
        this.environment = new HashMap<>();
    }

    @Override
    public Client getClient() {
        return null;
    }

    @Override
    public Map<String, String> getCustom() {
        return null;
    }

    @Override
    public Map<String, String> getEnvironment() {
        return this.environment;
    }
}
