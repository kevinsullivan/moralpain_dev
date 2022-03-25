package edu.uva.cs.moralpain.utils;

import org.junit.Test;

import java.util.regex.Pattern;

import static junit.framework.TestCase.assertTrue;

public class TestS3Helper {

    @Test
    public void testKey() {
        String pattern = "\\d{4}/\\d{2}/\\d{2}/\\d{2}/\\d{2}/\\d{2}/\\w{32}\\.json";
        assertTrue(Pattern.matches(pattern, S3Helper.createKey()));
    }
}
