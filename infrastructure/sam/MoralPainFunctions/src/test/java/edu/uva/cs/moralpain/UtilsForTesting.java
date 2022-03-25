package edu.uva.cs.moralpain;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;

public class UtilsForTesting {

    /**
     * Reads the object at the url into a string.
     * @param url the location to read
     * @return the stringified object
     */
    public static String fileToString(URL url) {
        StringBuilder stringBuilder = new StringBuilder();
        try(BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()))) {
            String line;
            while((line = br.readLine()) != null) {
                stringBuilder.append(line);
            }
        } catch(IOException e) {
            assert(false);
        }

        return stringBuilder.toString();
    }


}
