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
import com.google.gson.TypeAdapter;
import com.google.gson.annotations.JsonAdapter;
import com.google.gson.annotations.SerializedName;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import com.google.gson.TypeAdapterFactory;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.openapitools.client.JSON;

/**
 * VisitedResiliencyResources
 */
@javax.annotation.Generated(value = "org.openapitools.codegen.languages.JavaClientCodegen", date = "2022-08-05T21:06:39.147944Z[Etc/UTC]")
public class VisitedResiliencyResources {
  public static final String SERIALIZED_NAME_SELECTIONS = "selections";
  @SerializedName(SERIALIZED_NAME_SELECTIONS)
  private List<String> selections = null;

  public static final String SERIALIZED_NAME_TIMESTAMP = "timestamp";
  @SerializedName(SERIALIZED_NAME_TIMESTAMP)
  private Integer timestamp;

  public VisitedResiliencyResources() { 
  }

  public VisitedResiliencyResources selections(List<String> selections) {
    
    this.selections = selections;
    return this;
  }

  public VisitedResiliencyResources addSelectionsItem(String selectionsItem) {
    if (this.selections == null) {
      this.selections = new ArrayList<>();
    }
    this.selections.add(selectionsItem);
    return this;
  }

   /**
   * Get selections
   * @return selections
  **/
  @javax.annotation.Nullable
  @ApiModelProperty(value = "")

  public List<String> getSelections() {
    return selections;
  }


  public void setSelections(List<String> selections) {
    this.selections = selections;
  }


  public VisitedResiliencyResources timestamp(Integer timestamp) {
    
    this.timestamp = timestamp;
    return this;
  }

   /**
   * Get timestamp
   * @return timestamp
  **/
  @javax.annotation.Nullable
  @ApiModelProperty(value = "")

  public Integer getTimestamp() {
    return timestamp;
  }


  public void setTimestamp(Integer timestamp) {
    this.timestamp = timestamp;
  }



  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    VisitedResiliencyResources visitedResiliencyResources = (VisitedResiliencyResources) o;
    return Objects.equals(this.selections, visitedResiliencyResources.selections) &&
        Objects.equals(this.timestamp, visitedResiliencyResources.timestamp);
  }

  @Override
  public int hashCode() {
    return Objects.hash(selections, timestamp);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class VisitedResiliencyResources {\n");
    sb.append("    selections: ").append(toIndentedString(selections)).append("\n");
    sb.append("    timestamp: ").append(toIndentedString(timestamp)).append("\n");
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


  public static HashSet<String> openapiFields;
  public static HashSet<String> openapiRequiredFields;

  static {
    // a set of all properties/fields (JSON key names)
    openapiFields = new HashSet<String>();
    openapiFields.add("selections");
    openapiFields.add("timestamp");

    // a set of required properties/fields (JSON key names)
    openapiRequiredFields = new HashSet<String>();
  }

 /**
  * Validates the JSON Object and throws an exception if issues found
  *
  * @param jsonObj JSON Object
  * @throws IOException if the JSON Object is invalid with respect to VisitedResiliencyResources
  */
  public static void validateJsonObject(JsonObject jsonObj) throws IOException {
      if (jsonObj == null) {
        if (VisitedResiliencyResources.openapiRequiredFields.isEmpty()) {
          return;
        } else { // has required fields
          throw new IllegalArgumentException(String.format("The required field(s) %s in VisitedResiliencyResources is not found in the empty JSON string", VisitedResiliencyResources.openapiRequiredFields.toString()));
        }
      }

      Set<Entry<String, JsonElement>> entries = jsonObj.entrySet();
      // check to see if the JSON string contains additional fields
      for (Entry<String, JsonElement> entry : entries) {
        if (!VisitedResiliencyResources.openapiFields.contains(entry.getKey())) {
          throw new IllegalArgumentException(String.format("The field `%s` in the JSON string is not defined in the `VisitedResiliencyResources` properties. JSON: %s", entry.getKey(), jsonObj.toString()));
        }
      }
      // ensure the json data is an array
      if (jsonObj.get("selections") != null && !jsonObj.get("selections").isJsonArray()) {
        throw new IllegalArgumentException(String.format("Expected the field `selections` to be an array in the JSON string but got `%s`", jsonObj.get("selections").toString()));
      }
  }

  public static class CustomTypeAdapterFactory implements TypeAdapterFactory {
    @SuppressWarnings("unchecked")
    @Override
    public <T> TypeAdapter<T> create(Gson gson, TypeToken<T> type) {
       if (!VisitedResiliencyResources.class.isAssignableFrom(type.getRawType())) {
         return null; // this class only serializes 'VisitedResiliencyResources' and its subtypes
       }
       final TypeAdapter<JsonElement> elementAdapter = gson.getAdapter(JsonElement.class);
       final TypeAdapter<VisitedResiliencyResources> thisAdapter
                        = gson.getDelegateAdapter(this, TypeToken.get(VisitedResiliencyResources.class));

       return (TypeAdapter<T>) new TypeAdapter<VisitedResiliencyResources>() {
           @Override
           public void write(JsonWriter out, VisitedResiliencyResources value) throws IOException {
             JsonObject obj = thisAdapter.toJsonTree(value).getAsJsonObject();
             elementAdapter.write(out, obj);
           }

           @Override
           public VisitedResiliencyResources read(JsonReader in) throws IOException {
             JsonObject jsonObj = elementAdapter.read(in).getAsJsonObject();
             validateJsonObject(jsonObj);
             return thisAdapter.fromJsonTree(jsonObj);
           }

       }.nullSafe();
    }
  }

 /**
  * Create an instance of VisitedResiliencyResources given an JSON string
  *
  * @param jsonString JSON string
  * @return An instance of VisitedResiliencyResources
  * @throws IOException if the JSON string is invalid with respect to VisitedResiliencyResources
  */
  public static VisitedResiliencyResources fromJson(String jsonString) throws IOException {
    return JSON.getGson().fromJson(jsonString, VisitedResiliencyResources.class);
  }

 /**
  * Convert an instance of VisitedResiliencyResources to an JSON string
  *
  * @return JSON string
  */
  public String toJson() {
    return JSON.getGson().toJson(this);
  }
}

