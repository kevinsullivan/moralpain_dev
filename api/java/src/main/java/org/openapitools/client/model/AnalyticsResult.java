/*
 * MoralDistress API
 * MoralDistress API.
 *
 * The version of the OpenAPI document: 1.0.0
 * 
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */


package org.openapitools.client.model;

import java.util.Objects;
import java.util.Arrays;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonTypeName;
import com.fasterxml.jackson.annotation.JsonValue;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.math.BigDecimal;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import com.fasterxml.jackson.annotation.JsonTypeName;

/**
 * AnalyticsResult
 */
@JsonPropertyOrder({
  AnalyticsResult.JSON_PROPERTY_OPERATION,
  AnalyticsResult.JSON_PROPERTY_RESULT,
  AnalyticsResult.JSON_PROPERTY_ERROR,
  AnalyticsResult.JSON_PROPERTY_ERRORMSG
})
@JsonTypeName("analyticsResult")
@javax.annotation.Generated(value = "org.openapitools.codegen.languages.JavaClientCodegen", date = "2022-07-10T00:48:17.818184-04:00[America/New_York]")
public class AnalyticsResult {
  /**
   * Gets or Sets operation
   */
  public enum OperationEnum {
    AVERAGE("average"),
    
    COUNT("count"),
    
    MAXIMUM("maximum"),
    
    MINIMUM("minimum");

    private String value;

    OperationEnum(String value) {
      this.value = value;
    }

    @JsonValue
    public String getValue() {
      return value;
    }

    @Override
    public String toString() {
      return String.valueOf(value);
    }

    @JsonCreator
    public static OperationEnum fromValue(String value) {
      for (OperationEnum b : OperationEnum.values()) {
        if (b.value.equals(value)) {
          return b;
        }
      }
      throw new IllegalArgumentException("Unexpected value '" + value + "'");
    }
  }

  public static final String JSON_PROPERTY_OPERATION = "operation";
  private OperationEnum operation;

  public static final String JSON_PROPERTY_RESULT = "result";
  private BigDecimal result;

  public static final String JSON_PROPERTY_ERROR = "error";
  private Boolean error;

  public static final String JSON_PROPERTY_ERRORMSG = "errormsg";
  private String errormsg;

  public AnalyticsResult() { 
  }

  public AnalyticsResult operation(OperationEnum operation) {
    
    this.operation = operation;
    return this;
  }

   /**
   * Get operation
   * @return operation
  **/
  @javax.annotation.Nullable
  @ApiModelProperty(value = "")
  @JsonProperty(JSON_PROPERTY_OPERATION)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)

  public OperationEnum getOperation() {
    return operation;
  }


  @JsonProperty(JSON_PROPERTY_OPERATION)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)
  public void setOperation(OperationEnum operation) {
    this.operation = operation;
  }


  public AnalyticsResult result(BigDecimal result) {
    
    this.result = result;
    return this;
  }

   /**
   * Get result
   * @return result
  **/
  @javax.annotation.Nullable
  @ApiModelProperty(value = "")
  @JsonProperty(JSON_PROPERTY_RESULT)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)

  public BigDecimal getResult() {
    return result;
  }


  @JsonProperty(JSON_PROPERTY_RESULT)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)
  public void setResult(BigDecimal result) {
    this.result = result;
  }


  public AnalyticsResult error(Boolean error) {
    
    this.error = error;
    return this;
  }

   /**
   * Get error
   * @return error
  **/
  @javax.annotation.Nullable
  @ApiModelProperty(value = "")
  @JsonProperty(JSON_PROPERTY_ERROR)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)

  public Boolean getError() {
    return error;
  }


  @JsonProperty(JSON_PROPERTY_ERROR)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)
  public void setError(Boolean error) {
    this.error = error;
  }


  public AnalyticsResult errormsg(String errormsg) {
    
    this.errormsg = errormsg;
    return this;
  }

   /**
   * Get errormsg
   * @return errormsg
  **/
  @javax.annotation.Nullable
  @ApiModelProperty(value = "")
  @JsonProperty(JSON_PROPERTY_ERRORMSG)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)

  public String getErrormsg() {
    return errormsg;
  }


  @JsonProperty(JSON_PROPERTY_ERRORMSG)
  @JsonInclude(value = JsonInclude.Include.USE_DEFAULTS)
  public void setErrormsg(String errormsg) {
    this.errormsg = errormsg;
  }


  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    AnalyticsResult analyticsResult = (AnalyticsResult) o;
    return Objects.equals(this.operation, analyticsResult.operation) &&
        Objects.equals(this.result, analyticsResult.result) &&
        Objects.equals(this.error, analyticsResult.error) &&
        Objects.equals(this.errormsg, analyticsResult.errormsg);
  }

  @Override
  public int hashCode() {
    return Objects.hash(operation, result, error, errormsg);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class AnalyticsResult {\n");
    sb.append("    operation: ").append(toIndentedString(operation)).append("\n");
    sb.append("    result: ").append(toIndentedString(result)).append("\n");
    sb.append("    error: ").append(toIndentedString(error)).append("\n");
    sb.append("    errormsg: ").append(toIndentedString(errormsg)).append("\n");
    sb.append("}");
    return sb.toString();
  }

  /**
   * Convert the given object to string with each line indented by 4 spaces
   * (except the first line).
   */
  private String toIndentedString(Object o) {
    if (o == null) {
      return "null";
    }
    return o.toString().replace("\n", "\n    ");
  }

}

