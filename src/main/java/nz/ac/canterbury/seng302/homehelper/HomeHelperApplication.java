package nz.ac.canterbury.seng302.homehelper;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Home Helper web app entry-point
 * Note @link{SpringBootApplication} annotation
 * The @link{EnableScheduling} allows for scheduling tasks
 */
@EnableScheduling
@EnableAsync
@SpringBootApplication
public class HomeHelperApplication {

    /**
     * Main entry point, runs the Spring application
     *
     * @param args command line arguments
     */
    public static void main(String[] args) {
        SpringApplication.run(HomeHelperApplication.class, args);
    }

}
