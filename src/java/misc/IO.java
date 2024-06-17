package misc;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 *
 * @author Huenh
 */
public class IO {
    public static Path getPathToFile(String basePath, String subPath, String fileName) {
        try {
            Path path = Paths.get(basePath, subPath);
            Files.createDirectories(path);
            return Paths.get(path.toString(), fileName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static boolean exists(String basePath, String subPath, String fileName) {
        return Files.exists(Paths.get(basePath, subPath, fileName));
    }
}