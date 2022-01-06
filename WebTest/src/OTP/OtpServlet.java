package OTP;

import java.io.IOException;
import java.util.Arrays;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base32;

public class OtpServlet extends HttpServlet {

	@Override
    protected void service(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        byte[] buffer = new byte[5 + 5 * 5];
        
        new Random().nextBytes(buffer);

        Base32 codec = new Base32();
        byte[] secretKey = Arrays.copyOf(buffer, 10);
        byte[] bEncodedKey = codec.encode(secretKey);

        // 생성된 Key!
        String encodedKey = new String(bEncodedKey);
        // userName과 hostName은 변수로 받아서 넣어야 하지만, 여기선 테스트를 위해 하드코딩 해줬다.
        String url = getQRBarcodeURL("ksw8596", "gmail.com", encodedKey); // 생성된 바코드 주소!
        
        System.out.println("encodedKey : " + encodedKey);
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