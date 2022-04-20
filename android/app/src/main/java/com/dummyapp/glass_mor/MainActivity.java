package com.dummyapp.glass_mor;

import android.os.Bundle;
import android.os.Environment;
import android.os.StatFs;
import android.util.Log;
import java.io.File;
import com.amazonaws.mobile.client.AWSMobileClient;
import com.amazonaws.mobile.client.Callback;
import com.amazonaws.mobile.client.UserStateDetails;
import com.amplifyframework.core.Amplify;

import org.jetbrains.annotations.NotNull;

import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "flutter.native/helper";
    //    static final String userId = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

//    GeneratedPluginRegistrant.registerWith(this);
        //GeneratedPluginRegistrant.registerWith(new FlutterEngine(this));
        new MethodChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(@NotNull MethodCall call, @NotNull MethodChannel.Result result) {
                        if (call.method.equals("sendIDToAWSFromNative")) {
                            String id = call.argument("id");
                            String greetings = sendOpenIDToAWS(id);
//                                            String greetings = helloFromNativeCode(s);
                            result.success(greetings);
                            // Log.e("TAG", s);
                            // System.out.print(s
                        }
                        if(call.method.equals("getStorageFreeSpace")){
                            result.success(getStorageFreeSpace());
                        }
                        if(call.method.equals("getStorageTotalSpace")){
                            result.success(getStorageTotalSpace());
                        }
                    }
                });
    }


    private String sendOpenIDToAWS(String idToken) {
//        final String[] userID = new String[1];
        // Add this line, to include the Auth plugin.
        AWSMobileClient mobileClient =
                (AWSMobileClient) Amplify.Auth.getPlugin("awsCognitoAuthPlugin").getEscapeHatch();
        // Log.d("myTag", "This is my message");
        assert mobileClient != null;

        final String[] user = {""};
        mobileClient.federatedSignIn("securetoken.google.com/filesharing-1fe65", idToken,
                new Callback<UserStateDetails>() {
                    @Override
                    public void onResult(UserStateDetails userStateDetails) {
                        // return 'succesfull';
                        user[0] = userStateDetails.toString();
//                        Log.d("myTag", "" + user[0]);

                    }

                    @Override
                    public void onError(Exception e) {
                        //   return e;
//                        e.printStackTrace();
//                        Log.d("myTag", "This is my message in error callback $e");


                    }
                }
        );
        String userId = mobileClient.getIdentityId();
//        Log.i("myTag", userId);
        return userId;
    }
//    public Long getExternalStorageTotalSpace() {
//        File[] dirs = getExternalFilesDirs("");
//        StatFs stat = new StatFs(dirs[1].getPath().split("Android")[0]);
//        return stat.getTotalBytes();
//    }
//
//
//    public Long getExternalStorageFreeSpace() {
//        File[] dirs =getExternalFilesDirs("");
//        StatFs stat = new StatFs(dirs[1].getPath().split("Android")[0]);
////        Log.i("Internal", path.getPath());
//        return stat.getAvailableBytes();
//    }
    public Long getStorageTotalSpace() {
        File path = Environment.getDataDirectory();
        StatFs stat = new StatFs(path.getPath());
        return stat.getTotalBytes();
    }

    public Long getStorageFreeSpace(){
        File path = Environment.getDataDirectory();
        StatFs stat = new  StatFs(path.getPath());
        Log.i("Internal", path.getPath());
        return stat.getAvailableBytes();
    }

}
