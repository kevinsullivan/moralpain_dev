package edu.uva.cs.moralpain.s3;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import edu.uva.cs.moralpain.utils.VariableManager;
import software.amazon.awssdk.core.exception.SdkServiceException;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.util.HashMap;
import java.util.Map;

import static edu.uva.cs.moralpain.utils.S3Helper.createKey;
import static edu.uva.cs.moralpain.utils.S3Helper.createS3Client;

/**
 * Uploads the payload to S3.
 *
 * Bucket comes from the environment. Key follows the pattern, <y/MM/dd/HH/mm/ss/uuid.json>.
 *
 */
public class UniqueKeyUploader implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {

    @Override
    public APIGatewayV2HTTPResponse handleRequest(APIGatewayV2HTTPEvent apiGatewayV2HTTPEvent, Context context) {
        APIGatewayV2HTTPResponse response = new APIGatewayV2HTTPResponse();
        if(!isValidEvent(apiGatewayV2HTTPEvent)) {
            context.getLogger().log("invalid event");
            response.setStatusCode(500);
            return response;
        }

        VariableManager variableManager = new VariableManager();
        if(!isValidEnvironment(variableManager)) {
            context.getLogger().log("invalid environment");
            response.setStatusCode(500);
            return response;
        }
        String bucket = variableManager.get("bucket");
        String prefix = variableManager.getOrDefault("prefix", "");
        String key = prefix.isEmpty() ? createKey() : String.join("/", prefix, createKey());

        S3Client client = createS3Client(variableManager);
        try {
            client.putObject(PutObjectRequest.builder()
                    .bucket(bucket)
                    .key(key)
                    .build(), RequestBody.fromString(apiGatewayV2HTTPEvent.getBody()));
            response.setStatusCode(200);
        } catch(SdkServiceException exception) {
            context.getLogger().log(exception.getMessage());
            response.setStatusCode(500);
            return response;
        }

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


    private boolean isValidEvent(APIGatewayV2HTTPEvent event) {
        return !(event == null || event.getBody() == null || event.getBody().isEmpty());
    }

    private boolean isValidEnvironment(VariableManager variableManager) {
        return variableManager.containsKey("bucket") && !variableManager.getOrDefault("bucket", "").isEmpty();
    }
}
