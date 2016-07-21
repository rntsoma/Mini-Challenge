package androidcourse.venturus.org.br.androidcourse_firstexample;

import android.app.IntentService;
import android.app.NotificationManager;
import android.app.TaskStackBuilder;
import android.content.Context;
import android.content.Intent;
import android.support.v4.app.NotificationCompat;
import android.util.Log;


/**
 * An {@link IntentService} subclass for handling asynchronous task requests in
 * a service on a separate handler thread.
 * <p/>
 * TODO: Customize class - update intent actions and extra parameters.
 */
public class NotificationIntentService extends IntentService {

    private NotificationManager myNotificationManager;
    private int mId = 0;

    public NotificationIntentService() {
        super("NotificationIntentService");
    }

    private void sleep(int time){
        try{
            Thread.sleep(time);
        }catch (InterruptedException e){
            e.printStackTrace();
        }
    }

    @Override
    protected void onHandleIntent(Intent intent) {
        if (intent != null) {
            showNotification("Estou aqui", 4);
            sleep(5000);
            showNotification("Ainda estou aqui", 5);
            sleep(5000);
            showNotification("Tchau!", 6);
            sleep(5000);
        }
    }

    private void showNotification(String str, int version){
        NotificationCompat.Builder mBuilder =
                new NotificationCompat.Builder(this)
                .setContentTitle("My Notification")
                .setSmallIcon(R.mipmap.ic_launcher)
                .setContentText(str);
        myNotificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        myNotificationManager.notify(mId, mBuilder.build());
    }
}
