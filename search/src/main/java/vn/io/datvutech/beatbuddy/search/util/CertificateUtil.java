package vn.io.datvutech.beatbuddy.search.util;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

public class CertificateUtil {
    public static void importCertificate(String certFilePath) throws KeyManagementException, KeyStoreException,
            NoSuchAlgorithmException, CertificateException, IOException {

        InputStream certFileStream = CertificateUtil.class.getClassLoader().getResourceAsStream(certFilePath);
        X509Certificate ca = (X509Certificate) CertificateFactory.getInstance("X.509")
                .generateCertificate(new BufferedInputStream(certFileStream));
        certFileStream.close();

        KeyStore keystore = KeyStore.getInstance(KeyStore.getDefaultType());
        char[] password = "changeit".toCharArray(); // Default password is usually "changeit"
        keystore.load(null, password);
        keystore.setCertificateEntry("ca_certificate", ca);

        // Set JVM properties to use the custom keystore (optional)
        // System.setProperty("javax.net.ssl.trustStore", "path/to/your/keystore");
        // System.setProperty("javax.net.ssl.trustStorePassword",
        // "your_keystore_password");

        // Additional properties if needed:
        // System.setProperty("javax.net.ssl.trustStoreType", "JKS");
        // System.setProperty("javax.net.ssl.trustStoreProvider", "SUN");

        // Optional: Print out the keystore content
        // Enumeration<String> aliases = keystore.aliases();
        // while (aliases.hasMoreElements()) {
        // String alias = aliases.nextElement();
        // System.out.println(alias);
        // }

        System.out.println("CA certificate imported successfully.");
    }

    public static void disableSSLCertificateValidation() {
        TrustManager[] trustAllCerts = new TrustManager[] {
                new X509TrustManager() {
                    public X509Certificate[] getAcceptedIssuers() {
                        return null;
                    }

                    public void checkClientTrusted(X509Certificate[] certs, String authType) {
                    }

                    public void checkServerTrusted(X509Certificate[] certs, String authType) {
                    }
                }
        };
        try {
            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
