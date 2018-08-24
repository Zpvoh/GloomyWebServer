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

    public InfoReader(){
        try {
            File file=new File("info");
            FileInputStream fileStream=new FileInputStream("info");
            Scanner input= new Scanner(fileStream);

            JOptionPane.showMessageDialog(null, file.getAbsolutePath());
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
