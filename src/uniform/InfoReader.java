package uniform;

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
            FileInputStream fileStream=new FileInputStream("info");
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
