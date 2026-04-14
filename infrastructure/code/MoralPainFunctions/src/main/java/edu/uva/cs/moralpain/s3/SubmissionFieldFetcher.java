package edu.uva.cs.moralpain.s3;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import edu.uva.cs.moralpain.utils.S3Helper;
import edu.uva.cs.moralpain.utils.VariableManager;

import org.openapitools.client.model.Submission;

import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ListObjectsV2Request;
import software.amazon.awssdk.services.s3.model.S3Object;

import java.util.Collections;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import static edu.uva.cs.moralpain.utils.S3Helper.createS3Client;

/**
 * Get the timestamp of the submission with the given UUID
 */
public class SubmissionFieldFetcher implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {

    @Override
    public APIGatewayV2HTTPResponse handleRequest(APIGatewayV2HTTPEvent input, Context context) {
        APIGatewayV2HTTPResponse response = new APIGatewayV2HTTPResponse();
        if (!isValidEvent(input)) {
            context.getLogger().log("invalid event");
            response.setStatusCode(500);
            return response;
        }

        VariableManager variableManager = new VariableManager();
        if (!isValidEnvironment(variableManager)) {
            context.getLogger().log("invalid environment");
            response.setStatusCode(500);
            return response;
        }

        // String bucket = variableManager.get("bucket");
        // String prefix = variableManager.getOrDefault("prefix", "");

        // Map<String, String> qs = input.getQueryStringParameters();
        // if (qs == null) {
        // qs = Collections.EMPTY_MAP;
        // }
        // SubmissionFetcherPredicateBuilder sfpb = new
        // SubmissionFetcherPredicateBuilder(qs);
        // String uuid = qs.get("uuid");

        // If no UUID is given, return a 400 response.
        // if (uuid == null) {
        // response.setBody("Required UUID parameter is missing");
        // response.setStatusCode(400);
        // } else {
        // Get the list of submissions with the given UUID
        // System.out.println("before create client");
        S3Client client = createS3Client(variableManager);
        // System.out.println("before getObjectAsSubmisison");
        
        // TODO: don't deserialize JSON just to serialize it again
        Submission submission = S3Helper.getObjectAsSubmission(client, "moralpain-submissions-26",
                "single/submission.json");
        // System.out.println("after getObjectAsSubmission, submission = " + submission);

        // String apiPath = input.getRawPath() != null ? input.getRawPath() : "null";
        // Return timestamp if path is /submission/timestamp
        // if (apiPath.equals("/submission/timestamp")) {
        response.setBody(toJson(submission));
        response.setStatusCode(200);
        // }
        // // Return 500 response if path is invalid
        // else {
        // response.setBody("API path " + apiPath + " is not supposed to use this
        // lambda.");
        // response.setStatusCode(500);
        // }
        // }

        Map<String, String> headers = new HashMap<>();
        headers.put("Content-Type", "application/json");
        headers.put("X-Custom-Header", "application/json");
        // Cors.
        headers.put("Access-Control-Allow-Headers", "Content-Type,X-Amz-Date,Authorization,X-Api-Key");
        headers.put("Access-Control-Allow-Origin", "*");
        headers.put("Access-Control-Allow-Methods", "*");
        response.setHeaders(headers);

        return response;
    }

    private String toJson(Object value) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            return objectMapper.writeValueAsString(value);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return "";
    }

    private boolean isValidEvent(APIGatewayV2HTTPEvent event) {
        // TODO: uncomment
        // return event != null;
        return true;
    }

    private boolean isValidEnvironment(VariableManager variableManager) {
        // TODO: uncomment
        // return variableManager.containsKey("bucket") &&
        // !variableManager.getOrDefault("bucket", "").isEmpty();
        return true;
    }

}
