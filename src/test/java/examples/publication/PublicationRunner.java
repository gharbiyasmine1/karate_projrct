package examples.publication;
import com.intuit.karate.junit5.Karate;


public class PublicationRunner {
    @Karate.Test
     Karate testPublication() {
        return Karate.run("publication").relativeTo(getClass());
    }   
    
}
