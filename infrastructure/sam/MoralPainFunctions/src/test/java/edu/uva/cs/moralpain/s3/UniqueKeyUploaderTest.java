package edu.uva.cs.moralpain.s3;

import com.adobe.testing.s3mock.junit4.S3MockRule;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.Bucket;
import com.amazonaws.services.s3.model.ObjectListing;
import edu.uva.cs.moralpain.UtilsForTesting;
import org.junit.After;
import org.junit.Before;
import org.junit.ClassRule;
import org.junit.Test;

import java.net.URL;
import java.util.List;

import static org.junit.Assert.*;

public class UniqueKeyUploaderTest {

  @ClassRule
  public static final S3MockRule S3_MOCK_RULE = S3MockRule.builder().silent().build();

  private static final String BUCKET_NAME = "test-submissions";

  private final AmazonS3 s3Client = S3_MOCK_RULE.createS3Client();

  @Before
  public void setup() {
    s3Client.createBucket(BUCKET_NAME);
  }

  @After
  public void teardown() {
    s3Client.listBuckets().stream()
            .map(Bucket::getName)
            .map(s3Client::listObjects)
            .map(ObjectListing::getObjectSummaries)
            .flatMap(List::stream)
            .forEach(obj -> s3Client.deleteObject(obj.getBucketName(), obj.getKey()));
    s3Client.listBuckets().stream()
            .map(Bucket::getName)
            .forEach(s3Client::deleteBucket);
  }

  @Test
  public void testSurveyUploadedToS3() {
    initializeEnvironment();
    UniqueKeyUploader uniqueKeyUploader = new UniqueKeyUploader();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    URL url = getClass().getResource("/exampleSurveyResult.json");
    event.setBody(UtilsForTesting.fileToString(url));
    APIGatewayV2HTTPResponse result01 = uniqueKeyUploader.handleRequest(event, new MockContext());
    APIGatewayV2HTTPResponse result02 = uniqueKeyUploader.handleRequest(event, new MockContext());

    assertEquals(2, s3Client.listObjects(BUCKET_NAME).getObjectSummaries().size());
    assertNotEquals(500, result01.getStatusCode());
    assertNotEquals(500, result02.getStatusCode());
  }

  @Test
  public void testSurveyUploadedToS3WithPrefix() {
    initializeEnvironment();
    System.setProperty("prefix", "foo");
    UniqueKeyUploader uniqueKeyUploader = new UniqueKeyUploader();

    APIGatewayV2HTTPEvent event = new APIGatewayV2HTTPEvent();
    URL url = getClass().getResource("/exampleSurveyResult.json");
    event.setBody(UtilsForTesting.fileToString(url));
    uniqueKeyUploader.handleRequest(event, new MockContext());

    assertTrue(s3Client.listObjects(BUCKET_NAME).getObjectSummaries().get(0).getKey().contains("foo"));
  }

  private void initializeEnvironment() {
    System.setProperty("overrideEndpoint", S3_MOCK_RULE.getServiceEndpoint());
    System.setProperty("accessKeyId", "foo");
    System.setProperty("secretAccessKey", "bar");
    System.setProperty("bucket", BUCKET_NAME);
  }

}
