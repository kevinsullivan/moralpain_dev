package edu.uva.cs.moralpain.s3;

import com.amazonaws.services.lambda.runtime.LambdaLogger;

public class MockLogger implements LambdaLogger {

    @Override
    public void log(String message) {
        System.out.println(message);
    }

    @Override
    public void log(byte[] message) {
        System.out.println(message);
    }
}
