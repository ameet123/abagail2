package example;

import org.junit.Test;

import java.io.IOException;

public class EyeStateTestTest {
    private static final String eyeFile = "C:\\Users\\AF55267\\Documents\\personal\\ML\\homework\\hw-2\\abagail2" +
            "\\data\\foo.csv";

    @Test
    public void testEye() throws IOException {
        new EyeStateTest("data/foo.csv");
    }

}