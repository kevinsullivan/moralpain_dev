package edu.uva.cs.moralpain.utils;

import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

import static org.junit.Assert.assertEquals;

/**
 * Simple Tests to make sure the SurveyResult model aligns with the data.
 */
public class TestVariableManager {

  /**
   * Note that the environment is immutable and user dependent so
   * it is hard to check.
   */
  @Test
  public void testUserDefinedArePreferred() {
    Map<String, String> preferred = new HashMap<>();
    preferred.put("President", "Roosevelt");

    System.setProperty("President", "Nixon");

    VariableManager variableManager = new VariableManager(preferred);

    String expected = "Roosevelt";
    String actual = variableManager.get("President");
    assertEquals(expected, actual);
  }

  @Test
  public void testEnvironmentPreferredToSystemProp() {
    if(System.getenv().isEmpty()) {
      return;
    }

    String envKey = System.getenv().keySet().toArray()[0].toString();
    String envVal = System.getenv(envKey);

    System.setProperty(envKey, "SYSTEM_PROP_" + envVal);

    VariableManager variableManager = new VariableManager();
    String actual = variableManager.get(envKey);
    assertEquals(envVal, actual);
  }

  @Test
  public void testDefaultValue() {
    VariableManager variableManager = new VariableManager();

    String expected = "Adlai Stevenson";
    String actual = variableManager.getOrDefault("Ambassador", "Adlai Stevenson");
    assertEquals(expected, actual);
  }
}
