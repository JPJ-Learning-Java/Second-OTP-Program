package otp;
import java.io.IOException;
import java.util.Arrays;
import java.util.Random;
 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.codec.binary.Base32;
 
public class otp extends HttpServlet {
 
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
         
        // Allocating the buffer
//      byte[] buffer = new byte[secretSize + numOfScratchCodes * scratchCodeSize];
        byte[] buffer = new byte[5 + 5 * 5];
         
        // Filling the buffer with random numbers.
        // Notice: you want to reuse the same random generator
        // while generating larger random number sequences.
        new Random().nextBytes(buffer);
 
        // Getting the key and converting it to Base32
        Base32 codec = new Base32();
//      byte[] secretKey = Arrays.copyOf(buffer, secretSize);
        byte[] secretKey = Arrays.copyOf(buffer, 5);
        byte[] bEncodedKey = codec.encode(secretKey);
         
        // �깮�꽦�맂 Key!
        String encodedKey = new String(bEncodedKey);
         
        System.out.println("encodedKey : " + encodedKey);
         
//      String url = getQRBarcodeURL(userName, hostName, secretKeyStr);
        // userName怨� hostName�� 蹂��닔濡� 諛쏆븘�꽌 �꽔�뼱�빞 �븯吏�留�, �뿬湲곗꽑 �뀒�뒪�듃瑜� �쐞�빐 �븯�뱶肄붾뵫 �빐以щ떎.
        String url = getQRBarcodeURL("hj", "company.com", encodedKey); // �깮�꽦�맂 諛붿퐫�뱶 二쇱냼!
        System.out.println("URL : " + url);
         
        String view = "/otpTest.jsp";
         
        req.setAttribute("encodedKey", encodedKey);
        req.setAttribute("url", url);
         
        req.getRequestDispatcher(view).forward(req, res);
         
    }
     
    public static String getQRBarcodeURL(String user, String host, String secret) {
        String format = "http://chart.apis.google.com/chart?cht=qr&amp;chs=300x300&amp;chl=otpauth://totp/%s@%s%%3Fsecret%%3D%s&amp;chld=H|0";
         
        return String.format(format, user, host, secret);
    }
     
}