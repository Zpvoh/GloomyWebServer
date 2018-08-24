package uniform;

import javax.swing.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;

public class InfoReader {
    private String ip;
    private String username;
    private String pass;
    public String path;

    public InfoReader(){
        try {
            File file=new File(InfoReader.class.getResource("info").getFile());
            path=file.getAbsolutePath();

            FileInputStream fileStream=new FileInputStream(file);
            Scanner input= new Scanner(fileStream);
            ip=input.nextLine();
            username=input.nextLine();
            pass=input.nextLine();
            fileStream.close();
        } catch (FileNotFoundException e) {
            System.out.println("no info file");
        } catch (IOException e) {
            System.out.println("IO problem");
        }

    }

    public String getIp() {
        return ip;
    }

    public String getUsername() {
        return username;
    }

    public String getPass() {
        return pass;
    }
}
