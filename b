package com.hipro.bleservice;

import static com.ble.hipro.SelfCheckActivity.PARAM_DOWNLOAD_FAIL;
import static com.ble.hipro.SelfCheckActivity.PARAM_DOWNLOAD_OK;
import static com.ble.hipro.content.PrintData.getBytesListTest;

import android.annotation.SuppressLint;
import android.app.IntentService;
import android.app.Notification;
import android.app.PendingIntent;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothGattCharacteristic;
import android.bluetooth.BluetoothGattDescriptor;
import android.bluetooth.BluetoothGattService;
import android.bluetooth.BluetoothManager;
import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.content.res.AssetManager;
import android.database.Cursor;
import android.net.ConnectivityManager;
import android.net.Uri;
import android.net.wifi.WifiConfiguration;
import android.net.wifi.WifiManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.Messenger;
import android.os.SystemClock;
import android.preference.PreferenceManager;
import android.support.test.espresso.core.deps.guava.reflect.TypeToken;
import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;

import com.alibaba.fastjson.JSON;
import com.ble.hipro.ControlTestedInfo;
import com.ble.hipro.HiproApplication;
import com.ble.hipro.HiproConf;
import com.ble.hipro.R;
import com.ble.hipro.SelfCheckActivity;
import com.ble.hipro.WorkActivity;
import com.ble.hipro.WorkActivity.TestChannel;
import com.ble.hipro.bt.A3BLEProcessor;
import com.ble.hipro.bt.A3BLEProcessor.A3QrInstruction;
import com.ble.hipro.bt.A3Processor;
import com.ble.hipro.content.HiproData;
import com.ble.hipro.content.HiproData.Samples;
import com.ble.hipro.content.HsCrpDoubleResultPrintData;
import com.ble.hipro.content.LisDataV2;
import com.ble.hipro.content.ShowResData;
import com.ble.hipro.jsdata.RatioData;
import com.ble.hipro.jsdata.RatioDataLast;
import com.ble.ui.UPLoadLocation;
import com.ble.utils.HandlerThreadUtils;
import com.ble.utils.LogUtil;
import com.ble.utils.NetworkUtils;
import com.ble.utils.PackageTool;
import com.ble.utils.SpUtils;
import com.ble.utils.StrValidate;
import com.google.gson.Gson;
import com.hipro.Mysource.UPLoadTestedResult;
import com.hipro.bean.ResultUpNetBean;
import com.hipro.bluettothmod.BluetoothMod;
import com.hipro.broadreveiver.Constants;
import com.hipro.broadreveiver.NetworkReceiver;
import com.hipro.bugpatch.BackMainThread;
import com.hipro.bugpatch.BluetoothBug;
import com.hipro.bugpatch.Defaultconstant;
import com.hipro.bugpatch.PaidTagUtil;
import com.hipro.comm.wifiActions.WiFiAction;
import com.hipro.comm.wifiActions.WifiAPUtil;
import com.hipro.comm.wifiActions.WifiAdmin;
import com.hipro.common.FileReadWrite;
import com.hipro.common.NumberConver;
import com.hipro.common.XMLHelper;
import com.hipro.httpcommon.HttpUtils;
import com.hipro.httpcommon.ServerInfoSSi;
import com.hipro.location.GPSLocationTest;
import com.hipro.location.SCell;
import com.hipro.location.WifiBaseStaionInfo;
import com.hipro.location.WifiInfoManager;
import com.hipro.tcpdata.ByteDataTcp;
import com.hipro.tcphelp.MyTcpClent;
import com.hipro.tcphelp.MyTcpServer;
import com.hipro.tcphelp.TcpMessage;
import com.hipro.tcphelp.TcpProc;
import com.huicheng.service.BluetoothLeService;
import com.huicheng.service.BluettothClassic;
import com.xu.savetime.utils.ByteCommon;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.util.EntityUtils;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.net.ServerSocket;
import java.net.Socket;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Vector;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.ReentrantLock;

import android_serialport_api.ByteUtil;
import android_serialport_api.MySeria;
import top.cuihp.serverlibrary.Constant;
import top.cuihp.serverlibrary.client.ClientConfig;
import top.cuihp.serverlibrary.client.MinaClient;
import top.cuihp.serverlibrary.msg.MsgBean;
import top.cuihp.serverlibrary.msg.MsgProc;
import top.cuihp.serverlibrary.server.MinaServer;
import top.cuihp.serverlibrary.server.ServerConfig;
import top.cuihp.serverlibrary.wifi.WifiChangedReceiver;
import top.cuihp.serverlibrary.wifi.WifiConfig;
import top.cuihp.serverlibrary.wifi.WifiControlUtils;

public class MyService extends IntentService {

    private String oncodeData = "myservice+++oncodeData";
    private boolean createServerTag = true;

    public static final String fengefu="￥";
    public MyService(String name) {
        super(name);
        // TODO Auto-generated constructor stub
    }

    public MyService() {
        super("service");

        // TODO Auto-generated constructor stub
    }


    private PaidTagUtil paidTagUtil = new PaidTagUtil();

    private Context context;
    public final static String TAG = MyService.class.getName();
    public final static String CLENT_TITLE = "clentName";
    public static final String LOCK = "lock";
    public static final String PRINTLOCK = "plock";
    public static final String GETBARCODELOCK = "Block";

    public static final String writeLock = "writlod";
    //
//	private static final int WriteRate=75;//发送序列，发送间隔
//	private static final int ThreadFinishTime = 100; //线程结束等待时间
    private static final int WRITE_SPEED = 70;
    private static final int PRINTER_SPEED = 100; //发送打印间隔
    private static final int PRINTER_SPEED_QIANRU = 100; //发送打印间隔 嵌入平板
    private static final int WRITE_WAIT_BACK_TIME = 80; //等待回传时间
    private static final int WRITE_RESEND_TIMES = 5;   //指令超时后重发次数

    public static final int CLENT_CONN = 1001;                                //开始连接
    public static final int CLENT_DISCONNECTED = 1004;//断开连接
    public static final int CLENT_DISCONNECTED1 = 1005;//断开连接
    public static final int CLENT_CONN_SUCESS = 1002;                            //连接蓝牙成功
    public static final int CLENT_CONN_CUT = 1003;                            //蓝牙连接断开

    public static final int CONNTODEVICE = 2001;                            //client连接服务请求
    public static final int DEVICE_DATA_RECEIVE = 2002;                        //service接收到数据
    public static final int DEVICE_DATA_SEND = 2003;                        //client发送数据
    public static final int DATA_SEND_BACK = 2004;                            //已经发送数据


    public static final int START_SELF_CHECK = 3001;                            //开始自检
    public static final int CHANNELS_CHECKED = 3002;                            //返回通道
    public static final int NET_CHECK_FINISH = 3003;                        //网络连接检测返回
    public static final int BLE_CONN_SUCESS = 3004;                            //蓝牙连接成功
    public static final int BLE_CONN_FAILE = 3005;                            //蓝牙连接失败
    public static final int BLE_CONN_CHANEL = 3006;                            //检测到通道
    public static final int BLE_SELF_CHECK_FINISH = 3007;                    //自检完成
    public static final int CHANNEL_HAND = 3008;                                //发送通道握手

    public static final int SENDTOPRINTER = 3009;                                //发送打印命令
    public static final int SENDTOPRINTERLIST = 3010;
    public static final int SENDTOLIS = 3013;                                    //发送Lis命令
    public static final int SENDTOBLE = 3011;                                    //

    public static final int GETBARCODE = 3014;                                //获取二维码
    public static final int GETBARCODE_FINISH = 3015;                        //获取二维码完成
    public static final int GETBARCODE_FAIL = 3016;                            //获取二维码失败


    public static final int SET_WRITE_STATE = 3012;                        //设置是否发送数据至BLE
    /*****************发送接收部分************************/
    public static volatile boolean isReceiveback = true;


    public static final int ENTER_BLETOOTH_SETTING = 10000; //开始进入蓝牙设置模式
    public static final int BLETOOTH_SETTING_MOD_SUCESS = 10001; //进入 蓝牙设置模式完成
    public static final int BLETOOTH_SETTING_MOD_FAILE = 10002; //进入蓝牙设置模式失败

    public static final int EXIT_BLUETOOTH_MOD = 10003;            //退出蓝牙设置模式
    public static final int EXIT_BLUETOOTH_MOD_SUCESS = 10004;    //退出蓝牙设置模式完成
    public static final int EXIT_BLUETOOTH_MOD_FAILE = 10005;    //退出蓝牙设置模式失败
    public static final int BLETOOTH_SETTING_MOD_DEV_CONN = 1006;  //蓝牙设置模式连接成功

    public static final int BLETOOTH_CONN_SUCESS = 10007;            //蓝牙连接成功
    public static final int BLETOOTH_START_UPDATE = 10008;        //开始传输数据
    public static final int BLETOOTH__END_UPDATE = 10009;            //数据传输结束
    public static final int BLUETOOTH_PER_RECEIVE = 10010;        //每收到条数据


    public static final int BLE_SERVICE_RECEIVE = 40005;   //BLE发现服务  ACTION_GATT_SERVICES_DISCOVERED
    public static final int BLE_START_READ = 40006; // ACTION_GATT_DATA_READ
    public static final int BLE_RSSI_RECEIVE = 40007; // ACTION_DATA_RSSI

    public static final int GET_S_PAR = 40008;  //获取散射参数
    public static final int PRA_RECEIVE = 40009;    //获取参数返回
    public static final int SET_S_PAR = 400010;    //设定散射参数


    public static final int UPLOAD_RESULT = 8001;
    public static final int UPLOAD_DATABASE_SHOW = 8002;

    public static final int UPLOAD_CONTROL = 8003;//质控信息上传
    public static final int UPLOAD_CLEAN = 8004;//清除数据的时候 清除未上传的记录

    public static final int BLE_DATA_RECEIVE = 400011; //蓝牙收到数据

    public static final int TST_PAR = 400012;    //测试下发系数

    /********WIFI消息************/
    public static MinaServer minaServer;
    public static MinaClient minaClient;
    public static List<String> templist = new ArrayList<>();
    private WifiChangedReceiver wifiReceiver;
    public static final int MESSAGE_AP_STATE_ENABLED = 500001;  //热点建立成功
    public static final int MESSAGE_AP_STATE_FAILED = 500002;      //热点建立失败
    public static final int WIFI_DATA_RECEIVE = 500003;
    public static final int WIFI_STATE_APCONN = 500004;
    public static final int WIFI_CHANEL_LIST_SEND = 500005;//发送通道信息
    public static final int WIFI_CHANNEL_RECEIVE = 500006;//主机收到测试通道
    public static final int WIFI_CLENT_DATA_RECEIVE = 500007;
    public static final int WIFI_AP_OPEND = 500008;
    public static final int WIFI_SERVER_CONN_STATE_CHANGE = 500009; //客户端连接状态改变
    public static final int WIFI_RECONNECT = 500010;//重新连接 AP 主机就是创建 从机就是链接
    public static final int WIFI_BREAK_OFF = 500011;//wifi断开
    public static final int WIFI_CONNECT = 500012;//wifi链接
    public static final int WIFI_ACTIVE_BREAK_OFF = 500013;//主动断开wifi链接
    public static final int WIFI_REDIAN = 500014;//主动断开wifi链接
    public static final int WIFI_DUAN = 500015;//主动断开
    public static final int WIFI_QUXIAOCESHI = 500016;//  取消测试
    public static final int WIFI_ERWEIMACHONGXINHUOQU = 500017;//二维码 重新获取
    public static final int WIFI_FASONGCESHIJIEGUO = 500018;//  发送测试结果
    public static final int WIFI_SHIFOUMAIBURUI = 500019;//  发送是否买普瑞模式
    public static final int WIFI_FASONGSHUJV = 500020;//  发送数据
    public static final int WIFI_FASONGSHUJV_1 = 500021;//  发送数据


    public static final int EnterReceShowTestMod = 600001;   //进入测试窗体将他模式
    public static final int ExitReceShowTestMod = 600002;     //推出测试窗体监听模式
    public static final int ShowTestMod_Print = 600003;       //打印测试结果

    //检测蓝牙连接时间
    public static final int CHECK_BLE_CONN_RATE = 3 * 1000;
    //等待蓝牙响应时间
    public static final int CHECK_BLE_STATE_WAITE = 5 * 1000;
    //等待蓝牙关闭时间
    public static final int BLE_CLOSE_WAITE = 3 * 1000;
    //等待蓝牙重新连接时间
    public static final int BLE_RECONNECTION_TIME_OUT = 10 * 1000;


    public static volatile boolean isShowTestMod = false;
    public static volatile boolean isCheckBLE = true;

    public static volatile long recTime = 0;

    public static volatile long order = 0;

    public static volatile boolean canInterrupt = false;

    public static volatile boolean canHandInterrupt = false;

    public static volatile long writelasttime = 0;

    public static volatile int connState = 0;

    public static volatile boolean canPrint = true;

    public static final int resendCount = 3;//无返回重发次数3次
    public static final int sendTimeout = 100;//指令发送超时时间100ms
    private boolean isSendBack = false;
    private ReentrantLock sendlock = new ReentrantLock();

    private volatile int errorTimes = 0;


    private void setSendLock(boolean b) {
        sendlock.lock();
        isSendBack = b;
        sendlock.unlock();
    }

    private boolean getSendLock() {
        sendlock.lock();
        boolean temp = isSendBack;
        sendlock.unlock();
        return temp;
    }

    private static ExecutorService mnoThreadPool = Executors.newSingleThreadExecutor();

    private static void mnoExe(Runnable task) {
        mnoThreadPool.execute(task);
    }

    //断开连接后重新连接次数
    public static int reconnCount = 0;
    //读写状态
    //private volatile boolean connError = false;		//是否存在连接异常
//	private volatile boolean isWriting =false;		//是否向蓝牙发送信息
//	private volatile boolean isSendToClent = false; //是否在向客户端发送信息
    private volatile boolean isConnecting = false;  //连接状态
    private volatile boolean isHandle = false;
    private volatile boolean isClosing = false;
    Handler srvHandler = new Handler();
    //	private boolean handFlag = false;
//发送指令队列
//	private Vector<byte[]> writeList = new Vector<byte[]>();
//	private Vector<Byte[]> writeList1 = new Vector<Byte[]>();
    Thread writeThread = null;

    //读取指令队列
    public Vector<byte[]> readList = new Vector<byte[]>();
    private volatile boolean isReading = false;
    private Thread readThread = null;
    public Vector<byte[]> writeList = new Vector<byte[]>();
    public Vector<byte[]> writeSucceBack = new Vector<byte[]>();
    public long WriteTime = 0;
    public static final Object Plock = new Object();

    private int connCount = 0;
    private volatile boolean canWrite = true;
    private ReentrantLock canwriteLock = new ReentrantLock();

    private boolean getCanWrite() {
        canwriteLock.lock();
        boolean t = canWrite;
        canwriteLock.unlock();
        return t;
    }

    private void setCanWrite(boolean t) {
        canwriteLock.lock();
        canWrite = t;
        canwriteLock.unlock();
    }

    private volatile int parCount = 0;
    private byte[] parData = new byte[48];
    private volatile boolean canWrite1 = true;
    private volatile boolean isReconn = false;

    private Vector<byte[]> printList = new Vector<byte[]>();
    private Vector<byte[]> lisList = new Vector<byte[]>();
    private Vector<byte[]> printSendSucess = new Vector<byte[]>();
    private Thread lisThread;
    private Thread printThread;
    private long lastPrintTime = 0;

    public static volatile boolean isSetChannel = false;

    private static Vector<String> getBarcodeList = new Vector<String>();

    public static int getBarcodeListSize() {
        return getBarcodeList.size();
    }

    private HashMap<String, Boolean> isReceiveBarcodMap = new HashMap<String, Boolean>();

    private volatile long getBarcodeLastTime = -1;
    private volatile int getBarcodeTimes = 0;

    private Vector<Integer> uploadeList = new Vector<Integer>();
    private Vector<ControlTestedInfo> ControlTestedInfolist = new Vector<ControlTestedInfo>();
    private boolean isStopUpload = false;
    private Thread uploadThread = null;
    private Thread uploadThread1 = null;
    private final long KEEP_ALIVE_TIME =300L;
    private final TimeUnit KEEP_ALIVE_TIME_UNIT = TimeUnit.MILLISECONDS;
    BlockingQueue<Runnable> taskQueue = new LinkedBlockingQueue<Runnable>();
    private final ExecutorService executorTakeTestTube =
            new ThreadPoolExecutor(1, 1, KEEP_ALIVE_TIME, KEEP_ALIVE_TIME_UNIT, taskQueue
//            );
                    , new NamedThreadFactory("上传线程"));
    private static ReentrantLock testLoc = new ReentrantLock();
    private static ReentrantLock testControlLoc = new ReentrantLock();
    //定时更新曲线 乔 5.20 每四小时一次
    private Runnable uploadRunnable1 = new Runnable() {
        @Override
        public void run() {

            while (true) {


                try {

                    Thread.sleep(1000 * 60 * 60 * 4);//
                    startDownloadParams();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    };

    //下载参数信息
    protected void startDownloadParams() {

        new AsyncTask<String, Integer, Integer>() {
            @Override
            protected void onCancelled() {
                // TODO Auto-generated method stub
                super.onCancelled();
            }

            @Override
            protected void onPostExecute(Integer result) {
                Log.e(TAG, "加载完成");
                super.onPostExecute(result);
            }

            @Override
            protected void onPreExecute() {
                super.onPreExecute();
            }

            @Override
            protected void onProgressUpdate(Integer... values) {
                // TODO Auto-generated method stub
                super.onProgressUpdate(values);
            }

            @Override
            protected Integer doInBackground(String... params) {
//                HiproConf.choiceServer(context);//////////////////////////////旧服务器
//                ServerInfoSSi.choiceServer(context);////////////////////////////x新服务器
                final int[] res = {0};

                res[0] = downLoadParms();
                return res[0];
            }

            /**
             * 下载曲线
             * @return
             */
            private int downLoadParms() {
//                String dataURL = HiproConf.DOWNLOAD_DATA_URL;

                String sampleLastDate = "";
                String controlLastDate = "";
                SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(context);
                String temp = sp.getString(HiproConf.UPDATE_ONLINE_TIME, "2015-01-01");
                if (temp.length() >= 10) {
                    controlLastDate = temp.substring(0, 10).replaceAll("-", "").substring(2);
                } else {
                    controlLastDate = "2015-01-01".substring(0, 10).replaceAll("-", "").substring(2);
                }

                if (controlLastDate.length() == 0) {
                    controlLastDate = "2015-01-01".substring(0, 10).replaceAll("-", "").substring(2);
                }


                String banbenhao = sp.getString(HiproConf.BANBENHAO, "");
                if (!TextUtils.equals(banbenhao, PackageTool.getAppVersion(context))) {
                    Log.e("selfcheck", "更换版本号从新下载曲线");
                    sp.edit().putString(HiproConf.BANBENHAO, PackageTool.getAppVersion(context)).commit();
                    controlLastDate = "2015-01-01".substring(0, 10).replaceAll("-", "").substring(2);
                }
                sampleLastDate = controlLastDate;
                HashMap<String, String> mymap = new HashMap<String, String>();
//                mymap.put("sample", sampleLastDate);
//                mymap.put("control", controlLastDate);
//                mymap.put("mNo", HiproConf.getInsNo());
//                mymap.put("simno", HiproConf.getSimCode());


                mymap.put("sample", sampleLastDate);
                mymap.put("control", controlLastDate);
                mymap.put("mNo", HiproConf.getInsNo());
                mymap.put("simno", HiproConf.getSimCode());


                String data = "";

                try {
                    data = ServerInfoSSi.getPar(mymap);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                try {


                    //解析JSON
                    if (!HiproConf.isLastServer) {
                        RatioData ratioData = JSON.parseObject(data, RatioData.class);
                        ratioData.parse();
                        ratioData.save(getContentResolver());
                        ratioData.save(getContentResolver(), context);
                    } else {
//                        RatioDataLast rationData= JSON.parseObject(data, RatioDataLast.class);
                        RatioDataLast rationData = new Gson().fromJson(data, RatioDataLast.class);
                        HttpUtils.LogNewServer("par data:" + rationData.toString());
                        //判断应用已经关闭了
                        if (uploadThread1 != null) {
                            rationData.savePars(context);
                        }


                    }

                    return PARAM_DOWNLOAD_OK;
                } catch (Exception ex) {
                    ex.printStackTrace();
                    HttpUtils.LogNewServer("par data Exptction ex :" + ex.toString());
                }


                return PARAM_DOWNLOAD_FAIL;

            }

            private String readAssetData() {
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                byte buf[] = new byte[1024];
                int len;

                InputStream inputStream = null;

                try {
                    inputStream = getResources().getAssets().open("down_json.txt");
                    while ((len = inputStream.read(buf)) != -1) {
                        outputStream.write(buf, 0, len);
                    }
                    outputStream.close();
                    inputStream.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }

                return outputStream.toString();
            }

        }.execute("");
    }

    //如果有测试结果完成时，需要把测试结果列表数据上传
    private Runnable uploadRunnable = new Runnable() {
        @Override
        public void run() {
            // TODO Auto-generated method stub
            Log.d("uploadmy", "上传线程开始运行" + "isClosing:--" + isClosing + "isClosing:--" + isStopUpload + "errorTimes:--" + errorTimes);
            while (!isClosing && !isStopUpload && errorTimes <= 10) {
//                Log.d("uploadmy", "1进入上传"+uploadeList.size()+"isClosing:--"+isClosing+"isClosing:--"+isStopUpload+"errorTimes:--"+errorTimes);
                if (uploadeList.size() > 0) {
//                    Log.d("uploadmy", "1testLoc.lock()");
                    testLoc.lock();
//                    Log.d("uploadmy", "t2estLoc.lock():");
                    if (uploadeList.size() > 0) {
                        int simpleIdIdx = uploadeList.get(0);
                        ResultUpNetBean resultUpNetBean = upLoad(simpleIdIdx);
                        String[] uploadInfo = null;
                        if (resultUpNetBean != null) {
                            uploadInfo = resultUpNetBean.getTestedInfo();
                        }

                        if (uploadInfo != null) {
                            try {
                                //上传测试结果，移除上传ID
                                String[] back = UPLoadTestedResult.postRes(resultUpNetBean);
                                ContentValues values = new ContentValues();
                                Uri uri = ContentUris.withAppendedId(Samples.CONTENT_URI, simpleIdIdx);
                                ContentResolver cr = context.getContentResolver();
//                        Integer r = 0;//是否上传服务器，0未上传，1已上传，-1新服务器上传失败 -2 旧服务器上传失败！
                                Integer r = 0;//是否上传服务器, 0 未上传,1 已上传 , -1服务器上传失败  -2 医院上传失败
                                //back[2] = 0 医院上传失败
                                Log.d("uploadmy", "2上传执行， back:");
                                if ("1".equals(back[0]) && "1".equals(back[2])) {
                                    values.put(Samples.NET_UPLOAD_NEW, "1");
                                    values.put(Samples.NET_UPLOAD_OLD, "1");
                                    values.put(Samples.NET_UPLOAD_HOSPITAL, "1");
                                    uploadeList.remove(0);
                                    errorTimes = 0;
                                    r = 1;
                                } else if ("1".equals(back[0])) {
                                    values.put(Samples.NET_UPLOAD_NEW, "1");
                                    values.put(Samples.NET_UPLOAD_OLD, "1");
                                    values.put(Samples.NET_UPLOAD_HOSPITAL, "0");
                                    uploadeList.remove(0);
                                    uploadeList.add(simpleIdIdx);
                                    r = -2;
                                    errorTimes++;
                                } else if ("1".equals(back[1])) {
                                    values.put(Samples.NET_UPLOAD_NEW, "error");
                                    values.put(Samples.NET_UPLOAD_OLD, "1");
                                    values.put(Samples.NET_UPLOAD_HOSPITAL, "1");
                                    uploadeList.remove(0);
                                    uploadeList.add(simpleIdIdx);
                                    r = -1;
                                    errorTimes++;
                                }

                                if (r == 0) {
                                    errorTimes++;
                                }
                                values.put(Samples.IS_UPLOADE, r);
//                                Uri uri = ContentUris.withAppendedId(HiproData.ControlResult.CONTENT_URI, controlsimpleid);
                                Cursor c = cr.query(uri, null, null, null, null);
                                if (c == null || c.getCount() <= 0) {
                                    if (c != null) {
                                        c.close();
                                    }
                                } else {
                                    int count = cr.update(uri, values, null, null);
                                }

                                LogUtil.d("uploadmy", "--strNetTagNew  " + r);

                                //当不是成功的时候 增加延迟时间
                                Log.d("uploadmy", "3进入上传" + uploadeList.size() + "isClosing:--" + isClosing + "isClosing:--" + isStopUpload + "errorTimes:--" + errorTimes);
                                if (errorTimes >= 9) {

                                    testLoc.unlock();
                                    Thread.sleep(1000 * 60 * 15);
                                    errorTimes--;
                                } else {
                                    Thread.sleep(1000);
                                    testLoc.unlock();
                                }
                                Log.d("uploadmy", "4进入上传" + uploadeList.size() + "isClosing:--" + isClosing + "isClosing:--" + isStopUpload + "errorTimes:--" + errorTimes);
                            } catch (Exception e) {
                                e.printStackTrace();
                                testLoc.unlock();
                            }
                        } else {

                            testLoc.unlock();

                            uploadeList.remove(0);

                        }
                    } else {
                        testLoc.unlock();
                    }
                } else if (ControlTestedInfolist.size() > 0) {
                    testControlLoc.lock();
                    if (ControlTestedInfolist.size() > 0) {

                        ControlTestedInfo temp = ControlTestedInfolist.get(0);
                        int simpleIdIdx = Integer.parseInt(temp.sampleId);
//                    UPLoadTestedResult.postControls(temp);
//                    ControlTestedInfolist.remove(0);
                        Log.d("uploadmy", "上传执行， id:" + simpleIdIdx);
                        ResultUpNetBean resultUpNetBean = upControlLoad(simpleIdIdx);
                        String[] uploadInfo = null;
                        if (resultUpNetBean != null) {
                            uploadInfo = resultUpNetBean.getTestedInfo();
                        }

                        if (uploadInfo != null) {
                            try {
                                //上传测试结果，移除上传ID
                                String[] back = UPLoadTestedResult.postControlRes(resultUpNetBean);
                                ContentValues values = new ContentValues();
                                Uri uri = ContentUris.withAppendedId(HiproData.ControlResult.CONTENT_URI, simpleIdIdx);
                                ContentResolver cr = context.getContentResolver();
//                        Integer r = 0;//是否上传服务器，0未上传，1已上传，-1新服务器上传失败 -2 旧服务器上传失败！
                                Integer r = 0;//是否上传服务器, 0 未上传,1 已上传 , -1服务器上传失败  -2 医院上传失败
                                //back[2] = 0 医院上传失败
                                Log.d("uploadmy", "上传执行， back:" + back);
                                if ("1".equals(back[0])) {

                                    ControlTestedInfolist.remove(0);
                                    r = 1;
                                    errorTimes = 0;
                                } else {

                                    ControlTestedInfolist.remove(0);
                                    ControlTestedInfo mControlTestedInfo = new ControlTestedInfo();
                                    mControlTestedInfo.sampleId = simpleIdIdx + "";
                                    ControlTestedInfolist.add(mControlTestedInfo);
                                    r = -1;
                                    errorTimes++;
                                }
                                if (r == 0) {
                                    errorTimes++;
                                }
                                values.put(HiproData.ControlResult.IS_UPLOADE, r);

                                Cursor c = cr.query(uri, null, null, null, null);
                                if (c == null || c.getCount() <= 0) {
                                    if (c != null) {
                                        c.close();
                                    }
                                } else {
                                    int count = cr.update(uri, values, null, null);
                                }
                                LogUtil.d("uploadmy", "--质控上传结果：  " + r);

                                //当不是成功的时候 增加延迟时间
                                if (errorTimes >= 9) {
                                    testControlLoc.unlock();
                                    Thread.sleep(1000 * 60 * 15);
                                    errorTimes--;
                                } else {
                                    Thread.sleep(1000);
                                    testControlLoc.unlock();
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {

                            }

                        } else {
                            testControlLoc.unlock();
                            ControlTestedInfolist.remove(0);
                        }
                    } else {
                        testControlLoc.unlock();
                    }


                } else {
                    Thread.currentThread();
                    try {
                        Thread.sleep(100);
                    } catch (Exception e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }

            }

            Log.d("uploadmy", "上传线程结束" + "isClosing:--" + isClosing + "isClosing:--" + isStopUpload + "errorTimes:--" + errorTimes);


        }

    };


    @SuppressLint("Range")
    private ResultUpNetBean upLoad(int simpleid) { //jojo
        //Log.e("", "upLoad, choice Data");
        Log.d("uploadmy", "获取数据，iD:" + simpleid);
        String[] testedInfo = new String[17];
        //获取上传信息
        ContentResolver cr = context.getContentResolver();
        Cursor c = null;
        ResultUpNetBean resultUpNetBean = new ResultUpNetBean();
        try {
            Uri uri = ContentUris.withAppendedId(Samples.CONTENT_URI, simpleid);
            c = cr.query(uri, null, null, null, null);
            if (c == null || c.getCount() <= 0) {
                if (c != null) {
                    c.close();
                }
                return null;
            }
            c.moveToFirst();
            //项目名称0
            int itemIdx = c.getColumnIndex(Samples.TEST_PROJECT);
            String pname = c.getString(itemIdx);
            Log.d("", "c==null:" + (c == null) + ", testedInfo==null:" + (testedInfo == null) + ",pname:" + pname + ",id:" + simpleid);
            testedInfo[0] = c.getString(itemIdx).trim();
            //样本类型1
            int samplTypeNo = c.getColumnIndex(Samples.SAMPLE_TYPE);
            String[] types = context.getResources().getStringArray(R.array.sample_type_enum);
            testedInfo[1] = types[c.getInt(samplTypeNo)];
            //批号2
            int lot_no = c.getColumnIndex(Samples.REAGENT_BATCH_NO);
            testedInfo[2] = c.getString(lot_no);
            //测试结果3
            int resultIdx = c.getColumnIndex(Samples.TEST_RESULT);
            int linearUpRefIdx = c.getColumnIndex(Samples.LINEAR_REFERENCE_UP_RANGE);
            int linearLowRefIdx = c.getColumnIndex(Samples.LINEAR_REFERENCE_DOWN_RANGE);
            int judgementIdx = c.getColumnIndex(Samples.RESULT_JUDGMENT);
            int declenIdx = c.getColumnIndex(Samples.DECIMAL_LEN);
            double linearUpRef = c.getDouble(linearUpRefIdx);
            double linearLowRef = c.getDouble(linearLowRefIdx);
            short judgement = c.getShort(judgementIdx);
            double result = getResult(c.getDouble(resultIdx), linearUpRef, linearLowRef, judgement);
            int declen = c.getInt(declenIdx);
            String resultString;
            //double result,		double linearDownRange, double linearUpRange,		int judgement, String unit , int decLen
            resultString = getResultString(result, linearLowRef, linearUpRef, judgement, "", declen).toString();
            resultString = c.getDouble(resultIdx) + "";
            testedInfo[3] = resultString;
            //位置坐标4
            testedInfo[4] = HiproConf.location;
            String[] xx = HiproConf.getPhoneState(context);

            //电话号码5
            testedInfo[5] = xx[1];
            //电话卡编号6
            testedInfo[6] = xx[2];
            //上传时间7
            Date date = new Date();
            DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            testedInfo[7] = format.format(date);
            //病人姓名8
            int paint_name_no = c.getColumnIndex(Samples.PATIENT_NAME);
            testedInfo[8] = c.getString(paint_name_no);
            //病人年龄9
            int paint_age_no = c.getColumnIndex(Samples.AGE);
            testedInfo[9] = c.getString(paint_age_no);
            //病人性别10
            int paint_sex_no = c.getColumnIndex(Samples.SEX);
            int createIdx = c.getColumnIndex(Samples.CREATE_STAMP);
            testedInfo[10] = c.getLong(createIdx) + "";
            //病人编号
            int patient_id = c.getColumnIndex(Samples.PATIENT_ID);
            testedInfo[11] = c.getString(patient_id);

            // LogUtil.i("uploadmy", "myservice---" + c.getString(patient_id));


            //通道信息
            int tc_id = c.getColumnIndex(Samples.TEST_CHANNEL);
            testedInfo[12] = c.getString(tc_id);
            //测试信息
            try {
                int testInfo_id = c.getColumnIndex(Samples.TEST_INFO);
                testedInfo[13] = c.getString(testInfo_id);
            } catch (Exception ex) {
                testedInfo[13] = "";
            }

            testedInfo[14] = "" + c.getLong(c.getColumnIndex(Samples.CREATE_STAMP));
            testedInfo[15] = "" + c.getString(c.getColumnIndex(Samples.TEST_INFO));
            testedInfo[16] = "" + c.getString(c.getColumnIndex(Samples.NET_id));

//        String net_upload_old = c.getString(c.getColumnIndex(Samples.NET_UPLOAD_OLD));
//        String net_upload_new = c.getString(c.getColumnIndex(Samples.NET_UPLOAD_NEW));
//        String net_upload_hospital = c.getString(c.getColumnIndex(Samples.NET_UPLOAD_HOSPITAL));

            String net_upload_old = "0";
            String net_upload_new = "0";
            String net_upload_hospital = "0";


            //Log.e("", "upLoad, begin upload");

            //上传


            resultUpNetBean.setTestedInfo(testedInfo);
            resultUpNetBean.setNet_upload_new(net_upload_new);
            resultUpNetBean.setNet_upload_old(net_upload_old);
            resultUpNetBean.setNet_upload_hospital(net_upload_hospital);

            Log.d("uploadmy", "getUPloadData，pname：" + pname + ",pname.contains(\"PG\"):" + pname.contains("PG"));
            if (pname.contains("PG")) {
                String conNames = c.getString(c.getColumnIndex(Samples.CON_PROJECT_NAME));
                String conRes = c.getString(c.getColumnIndex(Samples.CON_TEST_RESULT));
                String[] pNames = conNames.split("\n");
                String[] pRes = conRes.split("\n");
                Log.d("uploadmy", "getUPloadData，project_name：" + conNames + ",pNames.length:" + pNames.length);
                if (pNames.length == 3) {
                    resultUpNetBean.setConUpload(true);
                    for (int i = 0; i < 2; i++) {
                        String[] tempx = new String[testedInfo.length];
                        System.arraycopy(testedInfo, 0, tempx, 0, testedInfo.length);
                        tempx[0] = pNames[i];
                        tempx[3] = pRes[i];
                        resultUpNetBean.getTestedInfoList().add(tempx);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (c != null) {
                c.close();
            }
        }


        return resultUpNetBean;
    }

    private CharSequence getResultString(double result,
                                         double linearDownRange, double linearUpRange,
                                         short judgement, String unit) {

        if (judgement == HiproConf.JUDGEMENT_RESULT_LIEANER_UP) {
            return String.valueOf(linearUpRange) + " " + unit + "  \u2191";  //大于
            //return "> "+String.valueOf(linearUpRange) + " " + unit ;  //大于
        } else if (judgement == HiproConf.JUDGEMENT_RESULT_LIEANER_DOWN) {
            return String.valueOf(linearDownRange) + " " + unit + "  \u2193";  //小于
            //return "< "+String.valueOf(linearDownRange) + " " + unit;  //小于
        } else if (judgement == HiproConf.JUDGEMENT_RESULT_REF_UP) {
            return String.valueOf(result) + " " + unit + "  \u2191";
            //return "> "+String.valueOf(result) + " " + unit ;
        } else if (judgement == HiproConf.JUDGEMENT_RESULT_REF_DOWN) {
            return String.valueOf(result) + " " + unit + "  \u2193";
            //return "< "+String.valueOf(result) + " " + unit;
        }
        return String.valueOf(result) + " " + unit;
    }

    @SuppressLint("Range")
    private ResultUpNetBean upControlLoad(int controlsimpleid) { //jojo
        //Log.e("", "upLoad, choice Data");
        Log.d("upControlLoad", "获取数据，iD:" + controlsimpleid);
        String[] testedInfo = new String[17];
        //获取上传信息
        ContentResolver cr = context.getContentResolver();
        Cursor c = null;
        ResultUpNetBean resultUpNetBean = new ResultUpNetBean();
        try {
            Uri uri = ContentUris.withAppendedId(HiproData.ControlResult.CONTENT_URI, controlsimpleid);
            c = cr.query(uri, null, null, null, null);
            if (c == null || c.getCount() <= 0) {
                if (c != null) {
                    c.close();
                }
                return null;
            }
            c.moveToFirst();

            //项目名称0
            int itemIdx = c.getColumnIndex(HiproData.ControlResult.ITEM_NAME);
            String pname = c.getString(itemIdx);
            Log.d("", "c==null:" + (c == null) + ", testedInfo==null:" + (testedInfo == null) + ",pname:" + pname + ",id:" + controlsimpleid);
            testedInfo[0] = c.getString(itemIdx).trim();
            //样本类型1
            int samplTypeNo = c.getColumnIndex(HiproData.ControlResult.SAMPLE_TYPE);
            String[] types = context.getResources().getStringArray(R.array.sample_type_enum);
            testedInfo[1] = types[c.getInt(samplTypeNo)];
            //批号2
            int lot_no = c.getColumnIndex(HiproData.ControlResult.REAGENT_BATCH_NO);
            testedInfo[2] = c.getString(lot_no);
            //测试结果3
            int resultIdx = c.getColumnIndex(HiproData.ControlResult.TEST_RESULT);
            int linearUpRefIdx = c.getColumnIndex(HiproData.ControlResult.LINEAR_REFERENCE_UP_RANGE);
            int linearLowRefIdx = c.getColumnIndex(HiproData.ControlResult.LINEAR_REFERENCE_DOWN_RANGE);
            int judgementIdx = c.getColumnIndex(HiproData.ControlResult.RESULT_JUDGMENT);
            int resultUnitCol = c.getColumnIndex(HiproData.ControlResult.RESULT_UNIT);
            double linearUpRef = c.getDouble(linearUpRefIdx);
            double linearLowRef = c.getDouble(linearLowRefIdx);
            short judgement = c.getShort(judgementIdx);
            double result = getResult(c.getDouble(resultIdx), linearUpRef, linearLowRef, judgement);

            String resultUnit = c.getString(resultUnitCol);
            String resultString;
            //double result,		double linearDownRange, double linearUpRange,		int judgement, String unit , int decLen
            resultString = getResultString(c.getDouble(resultIdx), linearLowRef, linearUpRef, judgement, resultUnit).toString();
            testedInfo[3] = resultString;

            //质控批号4
            int batch_no = c.getColumnIndex(HiproData.ControlResult.BATCH_NO);
            testedInfo[4] = c.getString(batch_no);
            //靶值5
            int target_val = c.getColumnIndex(HiproData.ControlResult.TARGET_VALUE);
            testedInfo[5] = c.getString(target_val);
            //曲线参数6
            int curve_parameters = c.getColumnIndex(HiproData.ControlResult.CURVE_PARAMETERS);
            testedInfo[6] = c.getString(curve_parameters);
            //中间结果7
            int middle_reslut = c.getColumnIndex(HiproData.ControlResult.MIDDLE_RESULT);
            testedInfo[7] = c.getString(middle_reslut);
            //数据类型 8
            int data_type = c.getColumnIndex(HiproData.ControlResult.DATA_TYPE);

            testedInfo[8] = !TextUtils.isEmpty(c.getString(data_type)) ? c.getString(data_type) : "1";

            //生成时间 9
//        Date date = new Date();
//        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            int control_date = c.getColumnIndex(HiproData.ControlResult.CONTROL_DATE);
            testedInfo[9] = c.getLong(control_date) + "";

            //病人姓名8


            String net_upload_old = "0";
            String net_upload_new = "0";
            String net_upload_hospital = "0";


            //Log.e("", "upLoad, begin upload");

            //上传


            resultUpNetBean.setTestedInfo(testedInfo);
            resultUpNetBean.setNet_upload_new(net_upload_new);
            resultUpNetBean.setNet_upload_old(net_upload_old);
            resultUpNetBean.setNet_upload_hospital(net_upload_hospital);


        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (c != null) {
                c.close();
            }
        }

        return resultUpNetBean;
    }

    //如果拟便捷测试结果为测量上限，则返回测量上限，如果是测量下限，则返回测量下限,其余情况则返回测试结果
    private double getResult(double realResult, double linearUpRef,
                             double linearLowRef, short judgement) {


        LogUtil.i("tetresult", "resulttest   " + realResult);

        if (judgement == HiproConf.JUDGEMENT_RESULT_LIEANER_UP) {
            return linearUpRef;
        } else if (judgement == HiproConf.JUDGEMENT_RESULT_LIEANER_DOWN) {
            return linearLowRef;
        }
        return realResult;
    }

    private CharSequence getResultString(double result,
                                         double linearDownRange, double linearUpRange,
                                         int judgement, String unit, int decLen) {
        //String.format("%."+decLen+"f", f)
        //Log.e(TAG,"result:"+result+",linearDownRange:"+",linearUpRange:"+linearUpRange+",judgement:"+judgement+",unit:"+unit);
        if (judgement == HiproConf.JUDGEMENT_RESULT_LIEANER_UP) {//大于线性范围上限
            //Log.e(TAG, "Result1:"+String.valueOf(linearUpRange) + " " + unit +"  \u2191");  //大于
            //Log.e(TAG, "ResultA:"+"> "+String.valueOf(linearUpRange) + " " + unit );
            //return "> "+String.valueOf(linearUpRange) + " " + unit ;
            return "> " + String.format("%." + decLen + "f", linearUpRange) + " " + unit;
        } else if (judgement == HiproConf.JUDGEMENT_RESULT_LIEANER_DOWN) {//小于线性范围下线
            //Log.e(TAG, "Result2:"+String.valueOf(linearDownRange) + " " + unit +"  \u2193");
            //Log.e(TAG, "ResultB:"+"< "+String.valueOf(linearDownRange) + " " + unit);
            //return "< "+String.valueOf(linearDownRange) + " " + unit;  //小于
            return "< " + String.format("%." + decLen + "f", linearDownRange) + " " + unit;
        } else if (judgement == HiproConf.JUDGEMENT_RESULT_REF_UP) { //大于正常值范围上限
            //Log.e(TAG, "Result3:"+String.valueOf(result) + " " + unit +"  \u2191");
            //Log.e(TAG, "ResultC:"+"> "+String.valueOf(result) + " " + unit);
            //return String.valueOf(result) + " " + unit +"  \u2191";
            return String.format("%." + decLen + "f", result) + " " + unit + "  \u2191";
        } else if (judgement == HiproConf.JUDGEMENT_RESULT_REF_DOWN) {//小于于正常值范围下限
            //Log.e(TAG, "Result4:"+String.valueOf(result) + " " + unit +"  \u2193");
            //Log.e(TAG, "ResultD:"+"< "+String.valueOf(result) + " " + unit);
            //return String.valueOf(result) + " " + unit +"  \u2193";
            //return String.valueOf(result) + " " + unit +"  \u2193";
            return String.format("%." + decLen + "f", result) + " " + unit + "  \u2193";
        }
        //Log.e(TAG, String.valueOf(result) + " " + unit);
        //Log.e(TAG, String.valueOf(result) + " " + unit);
        //return String.valueOf(result) + " " + unit;
        return String.format("%." + decLen + "f", result) + " " + unit;
    }


    private void startUploade() {
        Log.d("qiao", "启动上传线程" + (uploadThread != null));
        if (uploadThread != null) {
            isStopUpload = true;
            uploadThread.interrupt();
            uploadThread = null;
            mhandler.postDelayed(new Runnable() {
                @Override
                public void run() {
                    // TODO Auto-generated method stub
                    startUploade();
                }
            }, 1000);
        }
        isStopUpload = false;
        errorTimes = 0;
        isClosing = false;

        uploadThread = new Thread(uploadRunnable);
        uploadThread.start();

        if (uploadThread1 != null) {
            uploadThread1.interrupt();
            uploadThread1 = null;
        }
        uploadThread1 = new Thread(uploadRunnable1);
        uploadThread1.start();

    }


    private byte[] HANDSHAKE_INS_BUF = {
            //帧头，地址，指令
            (byte) 0xff, 0x00, (byte) A3Processor.A3_HANDSHAKE_INS,
            //字节数据10个
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            //模块编号6个
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            //校验位，帧尾
            0x00, 0x00};
    private byte[] READ_DATA_SUCESS = {
            //帧头，地址，指令
            (byte) 0xff, (byte) 0x88, (byte) 0x88,
            //字节数据10个
            0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x10,
            //模块编号6个
            0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
            //校验位，帧尾
            0x01};
    //GPS定位
    private GPSLocationTest gpslocation;
    private SCell mycell;
    private WifiInfoManager winfi;

    private void getLocation() {
        //GPS定位
        gpslocation = new GPSLocationTest(context);
        gpslocation.starLocation();
        //基站信息
        try {
            HiproConf.myscell = WifiBaseStaionInfo.getCellInfo(context);
            HiproConf.myscell.StartGetBSSS(context);
        } catch (Exception exception) {
            exception.printStackTrace();
        }
        try {
            winfi = new WifiInfoManager(context);
            HiproConf.myWifis = winfi.dump();
        } catch (Exception exception) {
            exception.printStackTrace();
        }

        Log.e("qiao", "位置上传1");
        if (clentHandler != null) {
            clentHandler.postDelayed(new Runnable() {
                @Override
                public void run() {
                    try {
                        Log.e("qiao", "位置上传2");
                        UPLoadLocation.StartPost(context);
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                }
            }, 1000 * 60 * 5);//* 60 * 5
        }

    }

    private BluetoothMod bMod = null;

    private void exitBle() {
        exitCheckBle();
        if (target_chara != null) {
            target_chara = null;
        }
        if (mBluetoothLeService != null) {
            mBluetoothLeService.close();
            mBluetoothLeService = null;
        }
        Log.e("", "退出BLE连接");
    }

    private void enterBle() {
        Log.e("", "连接BLE");
//		mDeviceAddress =HiproConf.deviceMac;
//		connect(mDeviceAddress);
        //selfcheck();
        if (HiproConf.bluetoothVer != 2)
            ini_BLE();
        else
            ini_BLuettoth();
        connect(mDeviceAddress);
    }

    private boolean enterBluetoothMod() {
        bMod = new BluetoothMod(mBluetoothAdapter, bModHandler, context);
        return bMod.StartRunning();
    }

    private void exitBluetoothMod() {
        if (bMod != null)
            bMod.StopRunning();
        bMod = null;
    }

    private Handler bModHandler = new Handler(new Handler.Callback() {

        @Override
        public boolean handleMessage(Message msg) {
            // TODO Auto-generated method stub
            switch (msg.what) {

                case EXIT_BLUETOOTH_MOD:
                    enterBle();
                    break;
                case MyService.BLETOOTH_SETTING_MOD_SUCESS:  //服务运行，等待连接
                    sendToClent(BLETOOTH_SETTING_MOD_SUCESS, null);
                    break;
                case MyService.BLETOOTH_CONN_SUCESS:        //蓝牙连接成功
                    sendToClent(BLETOOTH_CONN_SUCESS, null);
                    break;
                case MyService.BLETOOTH__END_UPDATE:        //开始更新数据
                    sendToClent(BLETOOTH__END_UPDATE, null);
                    break;
                case MyService.BLETOOTH_START_UPDATE:        //更新数据完成
                    sendToClent(BLETOOTH_START_UPDATE, null);
                    break;
                case MyService.BLUETOOTH_PER_RECEIVE:        //收到一条数据
                    sendToClent(BLUETOOTH_PER_RECEIVE, msg.arg1, -1, null);
                    break;
            }
            return true;
        }
    });

    public void getChannels(byte[] data) {    //my检测通道
        if (isConnecting) {

            LogUtil.i("isConnecting", data.length + "-----------");
            for (String channel : HiproConf.channelList) {
                isQuDao=true;
                int i = A3BLEProcessor.passAdress(channel);

                if (data[i + 1] == (0xff & 0x01)) {   ////////////////////////

                    LogUtil.i("isConnecting", "isConnecting succ" + "-----------");
                    sendToClent(BLE_CONN_CHANEL, 0, 0, channel);
                    HiproConf.channels.add(channel);
                    //如果不显示测试结果
                    if (!HiproConf.showResult) {
                        byte[] data1 = A3BLEProcessor.buildStartControlInsData();
                        //byte[] data =A3BLEProcessor.buildExitControlInsData();
                        data1[1] = A3BLEProcessor.passAdress(channel);
                        data1[data1.length - 2] = A3BLEProcessor.chenk_byte(data1, 1, data1.length - 3);
                        writeData(data1);
                        Message msg = new Message();
                        msg.what = WIFI_FASONGSHUJV;
                        msg.obj = channel + "," + ByteCommon.Bytes2HexString(data1);
                        if (clentHandler != null) {
                            Log.e(TAG, "如果不显示测试结果");
                            clentHandler.sendMessage(msg);
                        }
                    }
                }
            }
            Log.e(TAG, " send chang finish getChannels , ");

            sendToClent(BLE_CONN_SUCESS, 0, 0, null);
            sendToClent(BLE_SELF_CHECK_FINISH, 0, 0, null);
//			startUpLoaPar();

            int networkType = Constants.getNetWorkStatus(context);
            if (networkType == Constants.NETWORK_WIFI)
                //startUpLoaPar_parTime()
                ;
        } else {

            mBluetoothLeService.set_isConnecting(true);
            Log.d(TAG, " 连接监听 10，   收到指令时间：" + System.currentTimeMillis());
        }
    }

    /*************** 蓝牙连接部分*****************/

    //蓝牙4.0的UUID,其中0000ffe1-0000-1000-8000-00805f9b34fb是广州汇承信息科技有限公司08蓝牙模块的UUID
    public static String HEART_RATE_MEASUREMENT = "0000ffe1-0000-1000-8000-00805f9b34fb";
    private BluetoothAdapter mBluetoothAdapter;
    //蓝牙地址
    private String mDeviceAddress;
    //蓝牙4.0 service,负责后台的蓝牙服务
    private BluetoothLeService mBluetoothLeService;
    private ArrayList<ArrayList<BluetoothGattCharacteristic>> mGattCharacteristics = new ArrayList<ArrayList<BluetoothGattCharacteristic>>();
    //蓝牙2.0 service
    BluettothClassic mybluettoth;
    private MySeria myport;
    private MySeria myprinter;
    private MySeria mylis;
    private volatile boolean isprintconn = false;
    private volatile boolean islisconn = false;
    public Vector<byte[]> printerreadList = new Vector<byte[]>();
    public Vector<byte[]> lisReadList = new Vector<byte[]>();


    //是否重新连接
    private boolean isReconnecte = false;
    private long reconnectionTime = 0;
    private static int RECONNTIME = 10 * 1000;
    //蓝牙特征值
    public static volatile BluetoothGattCharacteristic target_chara = null;
    private Handler mhandler = new Handler();
    private List<Handler> clentHome = new ArrayList<Handler>();
    private Handler clentHandler = new Handler() {
        public void handleMessage(Message msg) {
            Log.d("handler", "clentHandler,receiveMSG:" + msg.what);
            switch (msg.what) {
                case CONNTODEVICE:
//					mDeviceAddress= (String)msg.obj;
////					Log.e(TAG, "myservic conn device:"+mDeviceAddress);
//					mBluetoothLeService.connect(mDeviceAddress);
                    break;
                case CLENT_CONN: {

                    Log.e(TAG, "添加Handler");
                    Handler h = (Handler) msg.obj;
                    clentHome.add(h);
                    Message m = new Message();
                    m.what = CLENT_CONN_SUCESS;
                    h.sendMessage(m);

                    //自检activity时候不发送
                    if (msg.arg1 != HiproConf.Self_biaozhi) {
                        //从机
                        if (HiproConf.WifiMod == 2) {

                            if (minaClient != null) {
                                //未链接
                                if (connState < 2) {
                                    ini_WifiMod();
                                }
                            }
                        }
                    }


                }
                break;
                case CLENT_CONN_CUT:
                    Log.d(TAG, "蓝牙断开，重新连接");
                    connect(mDeviceAddress);
                    break;
                case CLENT_DISCONNECTED:
                    Log.e(TAG, "删除handler" + msg.arg1);

                    if (WIFI_DUAN == msg.arg1 || CLENT_DISCONNECTED1 == msg.arg1) {
                        //主机

                        if (minaServer != null) {
                            Log.e(TAG, "minaServer!=null");
                            for (String key : Constant.sessionMap.keySet()) {
                                Log.e(TAG, "告诉从机断开链接" + key);
                                minaServer.sendMessage(key, MsgProc.DISCONNECT, "");
                            }
                            minaServer.disConnect();
                            minaServer = null;
                        }else{
                            Log.e(TAG, "minaServer==null");
                        }


                        //从机
                        if (minaClient != null) {
                            Log.e(TAG, "告诉主机断开链接");
                            Gson gson = new Gson();
                            mSendTime = System.currentTimeMillis();
                            minaClient.sendMessage(HiproConf.clentid + "", MsgProc.DISCONNECT, gson.toJson(templist));
                            minaClient.disConnect();
                            minaClient = null;
                        }


                    }
                    if (CLENT_DISCONNECTED1 != msg.arg1) {
                        clentHome.remove(msg.obj);
                    }

                    break;
                case DEVICE_DATA_SEND: {///////////////////           sendxia
                    byte[] data = (byte[]) msg.obj;
                    LogUtil.i("canceltest:", ByteUtil.bytes2HexStr(data));
                    Log.e(HiproConf.tcpTag, "SendData:" + BluetoothLeService.Bytes2HexString(data));
                    if (HiproConf.WifiMod == 1) {
                        int mycode = data[1] & 0xFF;
                        Log.d(HiproConf.tcpTag, "mycode:" + mycode);
                        if (mycode < 48 && mycode > 3) {
//                            String cname = A3BLEProcessor.geChannelName(data[1]);
//                            if (cname.contains("A")) data[1] = 1;
//                            if (cname.contains("B")) data[1] = 2;
//                            if (cname.contains("C")) data[1] = 3;
//                            data[19] = A3BLEProcessor.chenk_byte(data, 1, 18);
//                            TcpMessage mymsg = new TcpMessage();
//                            mymsg.setMsgWaht(TcpProc.SendToClentData);
//                            mymsg.setMsgObj(BluetoothLeService.Bytes2HexString(data));
//                            sendtoServeClent(Integer.parseInt(cname.substring(0, 2)), mymsg);
                        } else {
                            Log.d(HiproConf.tcpTag, "write data1");


                            writeData(data);
                        }
                    } else {
                        writeData(data);
                        Log.d(HiproConf.tcpTag, "write data2");
                    }
                    //write(data);
                }
                break;
                case START_SELF_CHECK:
                    selfcheck();
                    break;
                case WIFI_RECONNECT:
                    Log.e(TAG, "重新链接");
                    ini_WifiMod();
                    break;
                case WIFI_QUXIAOCESHI:
                    Log.e(TAG, "取消测试");
                    if (HiproConf.WifiMod == 1) {
                        if (minaServer != null) {

                            String zifuchuan = (String) msg.obj;

                            int zifuchuan_jiqiBianHao = Integer.parseInt(zifuchuan.substring(0, zifuchuan.length() - 1));

//                            minaServer.sendMessage(zifuchuan_jiqiBianHao + "", MsgProc.ByteData_QUXIAOCESHI, (String) msg.obj);
                            biaoshi++;
                            addMessage(biaoshi, false);
                            sendTcpServerMessage(zifuchuan_jiqiBianHao + "", MsgProc.ByteData_QUXIAOCESHI, biaoshi + fengefu+ (String) msg.obj);
//                            for (String key : Constant.sessionMap.keySet()) {
//                                if(((String) msg.obj).contains(key)){
//                                    minaServer.sendMessage(key, MsgProc.ByteData_QUXIAOCESHI,  (String) msg.obj);
//                                }
//
//                            }
                        }


                    }
                    break;
                case WIFI_FASONGCESHIJIEGUO:
//                    Log.e(TAG, "发送测试结果");
//                    if (HiproConf.WifiMod == 1) {
//                        if (minaServer != null) {
//
//                            for (String key : Constant.sessionMap.keySet()) {
//                                minaServer.sendMessage(key, MsgProc.ByteData_TESTRESLUT, (String) msg.obj);
//                            }
//                        }
//                    }
                    break;
                case WIFI_FASONGSHUJV:
                    if (HiproConf.WifiMod == 1) {
                        if (minaServer != null) {

//                            Toast.makeText(context,"给从机发送指令",Toast.LENGTH_LONG).show();
                            String[] jieguo1 = ((String) msg.obj).split(",");
                            String zifuchuan = jieguo1[0];
                            int zifuchuan_jiqiBianHao = Integer.parseInt(zifuchuan.substring(0, zifuchuan.length() - 1));
//                            minaServer.sendMessage(zifuchuan_jiqiBianHao + "", MsgProc.ByteData_FASONGSHUJV,biaoshi + fengefu+ (String) msg.obj);
                            biaoshi++;
                            addMessage(biaoshi, false);
                            Log.e(TAG, "给从机发送指令"+(String) msg.obj+"--zifuchuan_jiqiBianHao:"+zifuchuan_jiqiBianHao);
                            sendTcpServerMessage(zifuchuan_jiqiBianHao + "", MsgProc.ByteData_FASONGSHUJV, biaoshi + fengefu+ (String) msg.obj);
                        }


                    }
                    break;
                 case WIFI_FASONGSHUJV_1:
                    if (HiproConf.WifiMod == 1) {
                        if (minaServer != null) {

//                            Toast.makeText(context,"给从机发送指令",Toast.LENGTH_LONG).show();
                            String[] jieguo1 = ((String) msg.obj).split(",");
                            String zifuchuan = jieguo1[0];
                            int zifuchuan_jiqiBianHao = Integer.parseInt(zifuchuan.substring(0, zifuchuan.length() - 1));
                            Log.e(TAG, "给从机单发结果发送指令"+(String) msg.obj+"--zifuchuan_jiqiBianHao:"+zifuchuan_jiqiBianHao);
                            for (String key : Constant.sessionMap.keySet()) {
                                Log.e(TAG, "给从机单发结果发送指令 key= "+ key + " and value= " + Constant.sessionMap.get(key));
                                minaServer.sendMessage(key + "", MsgProc.ByteData_FASONGSHUJV_1,-1 + fengefu+ (String) msg.obj);
                            }

//                            biaoshi++;
//                            addMessage(biaoshi, false);
//
//                            sendTcpServerMessage(zifuchuan_jiqiBianHao + "", MsgProc.ByteData_FASONGSHUJV, biaoshi + fengefu+ (String) msg.obj);
                        }


                    }
                    break;
                case WIFI_ERWEIMACHONGXINHUOQU:
                    Log.e(TAG, "重新获取二维码");

                    break;
                case CHANNEL_HAND:
                    byte[] b = HANDSHAKE_INS_BUF.clone();
                    b[1] = 0x01;
                    b[19] = A3BLEProcessor.chenk_byte(b, 1, 18);
                    //READ_DATA_SUCESS[19]=A3BLEProcessor.chenk_byte(READ_DATA_SUCESS, 1, 18)
                    //mBluetoothLeService.write(b);
                    //writeData(b);
                    break;
                case SENDTOPRINTER:
                    if (clentHandler != null) {
                        byte[] pd = (byte[]) msg.obj;
                        int speet = msg.arg1;
                        Printer printer = new Printer(clentHandler, pd, speet);
                        printer.start();
                    }


                    break;
                case SENDTOPRINTERLIST:
                    Log.e(TAG, "send print list time:" + System.currentTimeMillis());
                    ArrayList<byte[]> l = (ArrayList<byte[]>) msg.obj;

                    if (HiproConf.bluetoothVer != 0) {
                        printList.addAll(printList.size(), l);
                    } else {
                        printData(l);
                    }

                    break;
                case SENDTOLIS:

                    byte[] l1 = (byte[]) msg.obj;
                    Log.d("sendSlisData", "Lis发送数据:" + BluetoothLeService.Bytes2HexString(l1));
                    if (HiproConf.bluetoothVer != 0) {
                        lisList.add(l1.clone());
                    } else {
                        byte[] tempxx = new byte[l1.length + 2];
                        tempxx[0] = (byte) 0xFF;
                        tempxx[1] = 0x24;
                        System.arraycopy(l1, 0, tempxx, 2, l1.length);
                        mylis.WriteData(tempxx);
                    }
                    break;
                case SENDTOBLE:
                    byte[] bxx = (byte[]) msg.obj;
                    writeData(bxx);
                    break;
                case SET_WRITE_STATE:
                    Log.d("bleconn", "设置canWrite:" + (Boolean) msg.obj);
                    setCanWrite((Boolean) msg.obj);
                    break;
                case GETBARCODE:
                    synchronized (GETBARCODELOCK) {
                        Log.e(TAG, "加入二维码获取队列1:" + (String) msg.obj + ",lisSize:" + getBarcodeList.size());
                        getBarcodeList.add((String) msg.obj);
                        Log.e(TAG, "加入二维码获取队列2:" + (String) msg.obj + ",lisSize:" + getBarcodeList.size());
                    }
                    break;
                case GETBARCODE_FINISH:
                    Log.e("testState", "二维码获取 ，结束" + "TestChannel:" + (String) msg.obj + "Timer:" + System.currentTimeMillis());
//					synchronized(GETBARCODELOCK){
////					getBarcodeList.remove((String)msg.obj);
////					getBarcodeTimes=0;
//					boolean bx=isReceiveBarcodMap.keySet().contains((String)msg.obj);
//					//if(bx){
//							isReceiveBarcodMap.put((String)msg.obj, true);
//					//	}
//					}
//					synchronized(GETBARCODELOCK){
                    getBarcodeList.remove((String) msg.obj);
//						if(getBarcodeList.size()==0)
//							//canWrite=true;
//						}
                    break;
                case ENTER_BLETOOTH_SETTING:
                    exitBle();
                    enterBluetoothMod();
                    break;
                case EXIT_BLUETOOTH_MOD:
                    exitBluetoothMod();
                    enterBle();
                case BLE_SERVICE_RECEIVE:     //发现BLE服务
                    Log.e("bleconn", "发现BLE服务");
                    try {
                        displayGattServices(mBluetoothLeService.getSupportedGattServices());
                    } catch (Exception ex) {
                        Log.d(TAG, "发现BLE服务 错误：");
                        ex.printStackTrace();
                    }
                    break;
                case BLE_START_READ:          //读取数据///////蓝牙来数据啦！！  只是连接的时候调用一下
                    LogUtil.i("BLE_START_READ_test", "BLE读取数据");
                    if (!isConnecting) {
                        isConnecting = true;
                        setCanWrite(true);
                        writeThread = new Thread(writeRunnable);
                        writeThread.start();
                        if (printThread == null) {
                            printThread = new Thread(pritRunnable);
                            printThread.start();
                        }
                        startCheckBle();
                    }
                    break;
                case BLE_RSSI_RECEIVE:        //BLE信号强度
                    Log.e("", "BLE信号强度返回");
                    break;
                case UPLOAD_RESULT:
                    Log.d("", "上传队列：" + msg.arg1);
                    Integer ix = msg.arg1;
                    boolean isAdd = true;
                    if (null != uploadeList && uploadeList.size() > 0) {
                        for (int j : uploadeList) {
                            if (j == ix) {
                                isAdd = false;
                            }
                        }
                    }
                    if (isAdd) {
                        //去重添加
                        uploadeList.add(ix);
                    }

                    break;
                 case UPLOAD_CLEAN:
                    Log.d("", "清除未上传的数据");
                        uploadeList.clear();
                     ControlTestedInfolist.clear();


                    break;
                case UPLOAD_CONTROL:
                    //去重
                    ControlTestedInfo controlTestedInfo=(ControlTestedInfo) msg.obj;
                    boolean isAdd1 = true;
                    if (null != ControlTestedInfolist && ControlTestedInfolist.size() > 0) {
                        for ( ControlTestedInfo controlTestedInfo1 : ControlTestedInfolist) {
                            if (TextUtils.equals(controlTestedInfo1.sampleId,controlTestedInfo.sampleId)  ) {
                                isAdd1 = false;
                            }
                        }
                    }
                    if (isAdd1) {
                        //去重添加
                        ControlTestedInfolist.add(controlTestedInfo);
                    }

                    break;
                case BLE_DATA_RECEIVE:
                    byte[] mybyte = (byte[]) msg.obj;
                    String hesstr = BluetoothLeService.Bytes2HexString(mybyte);
                    System.out.println(" Clent BLE Receive Data ++++++++++++++++  Data: " + hesstr);
                    //HiproConf.writeFile(BluetoothLeService.hexpath, BluetoothLeService.hexFileName, hesstr+"\r\n");
                    readList.add(mybyte);//
                    break;
                case TST_PAR:
                    try {
                        //upLoaPar();
                        startUpLoaPar();
                    } catch (Exception ex) {
                        Log.e("getpar", "getpar,异常");
                        ex.printStackTrace();
                    }
                    break;
                case MyService.WIFI_CHANEL_LIST_SEND:
                    try {
                        Log.e(TAG, "发送通道信息");
                        templist = (List<String>) msg.obj;

                        TcpMessage tcpmsg = new TcpMessage();
                        tcpmsg.setMsgWaht(TcpProc.Channel_Conn);
                        tcpmsg.setMsgInt(HiproConf.clentid);
                        tcpmsg.setMsgObj(templist);
                        if (tcpclent != null) {
                            tcpclent.sendMsg(TcpProc.getMsgStr(tcpmsg));
                        }

                        if (minaClient != null) {
                            Log.e(TAG, "发送通道信息-已经实例化了,目前链接状态：" + connState);
                            Gson gson = new Gson();
                            mSendTime = System.currentTimeMillis();
//                            minaClient.sendMessage(HiproConf.clentid + "", MsgProc.Channel_Conn, gson.toJson(templist));
                            biaoshi++;
                            addMessage(biaoshi, false);
                            sendTcpMessage(HiproConf.clentid + "", MsgProc.Channel_Conn, biaoshi + fengefu+ gson.toJson(templist));

                        } else {
                            Log.e(TAG, "发送通道信息失败");
//                            Toast.makeText(context, "没有呢还", Toast.LENGTH_SHORT).show();
                        }


                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                    break;

                case EnterReceShowTestMod:
                    isShowTestMod = true;
                    initTestJiaoJian();
                    break;
                case ExitReceShowTestMod:
                    isShowTestMod = false;
                    break;
                case ShowTestMod_Print:
                    LogUtil.d("ShowTestResultActivity", "准备打印");
                    final ArrayList<ShowResData> temppList = (ArrayList<ShowResData>) msg.obj;
                    mnoExe(new Runnable() {
                        @Override
                        public void run() {
                            printTestResultList(temppList);
                        }
                    });
                    break;
            }
        }

        ;
    };

    /**
     * 乔 5.22 交检添加
     */
    private void initTestJiaoJian() {
        selfcheck();
    }

    private void printData(ArrayList<byte[]> pdata) {
        Log.e("qiao", "seral isprintconn:" + isprintconn);
        if (isprintconn) {
            long dalytime = 20;
            long nowtime = System.currentTimeMillis();
            if (lastPrintTime > nowtime) {
                dalytime = lastPrintTime - nowtime + PRINTER_SPEED_QIANRU;
            }

            for (int i = 0; i < pdata.size(); i++) {
                final byte[] data = pdata.get(i);
                mhandler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        // TODO Auto-generated method stub
                        myprinter.WriteData(data);
                    }
                }, dalytime);
                dalytime = dalytime + PRINTER_SPEED_QIANRU;
                lastPrintTime = System.currentTimeMillis() + dalytime;
            }
        }
    }

    private volatile int pthreadCount = 0;
    private Runnable pritRunnable = new Runnable() {
        @Override
        public void run() {
            // TODO Auto-generated method stub
            Printer print = new Printer();
            pthreadCount++;
            boolean printGetNew = true;
            int printSendTimes = 0;
            boolean isSendBack = false;
            int sendTimes = 0;
            //System.out.println("print threa count:" +pthreadCount);
            String cName = "";
            getBarcodeTimes = 0;
            HiproConf.MyLog("D", "BV2", "pritRunnable start Run");
            while (!isClosing) {
                if (mBluetoothLeService != null || (mybluettoth != null || HiproConf.bluetoothVer == 0))
                    if ((writeList.size() < 1) && isConnecting) {
                        if (((System.currentTimeMillis() - getBarcodeLastTime) > 7000) && (getBarcodeList.size() > 0)) {
                            synchronized (GETBARCODELOCK) {
                                if (getBarcodeTimes >= 1) {
                                    cName = getBarcodeList.remove(0);
                                    sendToClent(GETBARCODE_FAIL, 0, 0, cName);
                                    getBarcodeTimes = 0;
                                    if (getBarcodeList.size() < 1) continue;
                                }

                                //canWrite=false;
                                byte[] sendData = A3BLEProcessor.buildA3GetBarCode(getBarcodeList.get(0));
                                sendData[1] = A3BLEProcessor.passAdress((String) getBarcodeList.get(0));
                                sendData[19] = A3BLEProcessor.chenk_byte(sendData, 1, 18);

                                writeData(sendData);
                                Message msg = new Message();
                                msg.what = WIFI_FASONGSHUJV;
                                msg.obj = getBarcodeList.get(0) + "," + ByteCommon.Bytes2HexString(sendData);
                                if (clentHandler != null) {
                                    Log.e(TAG, "发送下位机指令");
                                    clentHandler.sendMessage(msg);
                                }
                                getBarcodeTimes++;
                                getBarcodeLastTime = System.currentTimeMillis();
                            }
                            } else if ((System.currentTimeMillis() - writelasttime > 500) && getCanWrite() && lisList.size() > 0
                                && canPrint
                        ) {
                            byte[] data = lisList.get(0);
                            print.sendLisData(data);
                            lisList.remove(0);
                        } else if ((System.currentTimeMillis() - writelasttime > 500) && getCanWrite() && printList.size() > 0
                                && canPrint) {

//					//如果未获取到版本号，按以前方式发送
                            byte[] data = printList.get(0);
                            if (HiproConf.getHDVerSion() == null) {
                                {
                                    writeData(data);
                                }
                                printList.remove(0);
                            } else {
                                data = printList.get(0);
                                //isSendBack = writeSucceBack.contains(data);
                                byte[] data1 = new byte[A3BLEProcessor.getFrameLen(0x32, null, 1)];
                                //synchronized(Plock)
                                {
                                    System.arraycopy(data, 0, data1, 0, data1.length);
                                    isSendBack = isHave(writeSucceBack, data1);
                                }

                                if (isSendBack || (sendTimes >= WRITE_RESEND_TIMES)) {  //如果返回成功，则获取下一条指令
                                    printList.remove(0);
                                    sendTimes = 0;
                                    if ((printList.size() > 0)) {
                                        data = printList.get(0);
                                    } else {
                                        data = null;
                                        isSendBack = false;
                                        continue;
                                    }
                                }
                                //如果发送成功，或等待超时，则重新发送
                                if (isSendBack || ((System.currentTimeMillis() - WriteTime) > WRITE_WAIT_BACK_TIME)) {
                                    writeData(data);
                                    isSendBack = false;
                                    WriteTime = System.currentTimeMillis(); //记录发送时间
								Log.e(TAG,"printlist 发送： "+BluetoothLeService.Bytes2HexString(data) +" time:"+ System.currentTimeMillis());
                                    sendTimes++;
                                }

                            }
                        }
                    }

                try {
                    Thread.sleep(PRINTER_SPEED);
                } catch (InterruptedException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
                //if(!HiproConf.Baarcode_Print)
                //canWrite=(System.currentTimeMillis()-getBarcodeLastTime)>7000;
            }
            HiproConf.MyLog("D", "BV2", "pritRunnable start stop");
        }
    };
    private byte[] lisBuffer = new byte[512];
    private int lisBufferLen = 0;
    private Runnable lisRunnable = new Runnable() {
        @Override
        public void run() {
            // TODO Auto-generated method stub

            //35

            while (isReading) {
                if (lisReadList.size() > 0) {
                    byte[] data = lisReadList.get(0);
                    lisReadList.remove(0);
                    LogUtil.i("ondatacome     ", "while (isReading) {");
                    System.arraycopy(data, 0, lisBuffer, lisBufferLen, data.length);
                    lisBufferLen += data.length;
                    Log.e(TAG, "Lis  read Count:" + data.length + "  read data:" + BluetoothLeService.Bytes2HexString(data) + "station:" + lisBufferLen);
                    try {
                        lisBufferLen = lisPars(lisBuffer, lisBufferLen);//处理当前读取数据，获取下次存放位置
                    } catch (Exception ex) {
                        Log.e("", "Lis Error  data:" + BluetoothLeService.Bytes2HexString(data) + "station:" + lisBufferLen);
                        ex.printStackTrace();
                    }
                    //bufferDataLen = parseData(buffer,bufferDataLen);
                } else {
                    try {
                        Thread.sleep(10);
                    } catch (InterruptedException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }

            }

        }
    };

    private int lisPars(byte[] buffer, int bufferDataLen) {

        LogUtil.i("ondatacome     ", "lisPars");
        if (bufferDataLen < 2) return bufferDataLen;
        int hand = buffer[0] & 0xff;
        //判断指令头
        if (hand == 0xFF) {

            //获取当前指令
            int insCode = 0xff & buffer[1];
            Log.e(TAG, "lis incode:" + insCode);
            //根据指令获取所需长度
            int frameLen = LisDataV2.getFrameLen(insCode, buffer, bufferDataLen);
            Log.e(TAG, "lis frameLen:" + frameLen);
            //1.变长帧未结束，2.固定长度帧数据不足
            if (frameLen == -1 || frameLen > bufferDataLen) return bufferDataLen;
            //未找到指令
            if ((frameLen == -2)) return 0;


            byte[] datax = new byte[frameLen];
            //复制接收检测到的本条数据，处理本条指令
            System.arraycopy(buffer, 0, datax, 0, frameLen);

            Log.d(TAG, "lis parseFrame1  Received  Data:" + BluetoothLeService.Bytes2HexString(datax) + ",Length:" + datax.length + ",isSetChannel:" + isSetChannel);

            if (LisDataV2.isLisCode(insCode)) {
                Log.e("", "Lis 数据");
                byte[] bx;
                switch (insCode) {
                    case LisDataV2.HANDLE_RECEIVE:   //Lis握手指令
                        bx = LisDataV2.buidHand();
                        sendLis(bx);
                        break;
                    case LisDataV2.CHECK_CHANNEL_RECEIVE: //获取通道信息
                        LogUtil.i("ondatacome     ", "CHECK_CHANNEL_RECEIVE");
                        int count = HiproConf.channelTestStateMap.size();
                        if (HiproConf.channelTestStateMap.containsKey(SelfCheckActivity.CHANNEL_LIS_NAME))
                            count--;
                        if (HiproConf.channelTestStateMap.containsKey(SelfCheckActivity.CHANNEL_PRINTER_NAME))
                            count--;
                        Iterator<Entry<String, TestChannel>> iter = HiproConf.channelTestStateMap.entrySet().iterator();
                        byte[] b = new byte[count];
                        count = 0;
                        while (iter.hasNext()) {
                            Entry<String, TestChannel> entry = iter.next();
                            TestChannel tc = entry.getValue();
                            if (tc.channelName.equals(SelfCheckActivity.CHANNEL_LIS_NAME) || tc.channelName.equals(SelfCheckActivity.CHANNEL_PRINTER_NAME))
                                continue;
                            b[count] = A3Processor.passAdress(tc.channelName);
                            count++;
                        }
                        bx = LisDataV2.buildChannelInfo(b);
                        sendLis(bx);
                        break;
                    case LisDataV2.SAMPLE_ID_RECEIVE:    //下发编号
                        //sendChannelInstruction(SelfCheckActivity.CHANNEL_LIS_NAME, LisDataV2.SAMPLE_ID_RECEIVE, data);//处理接收完成字节数

                        byte[] txxx = new byte[datax.length - 1];
                        txxx[0] = (byte) 0xFF;
                        txxx[1] = datax[0] = (byte) A3BLEProcessor.A3_BAR_CODE_INFO_INS;
                        System.arraycopy(datax, 2, txxx, 2, 15);
                        txxx[txxx.length - 2] = (byte) 0x0A;
                        txxx[txxx.length - 1] = (byte) 0x0D;


//								data[0] =(byte) 0xFF;
//								data[1] = (byte)A3BLEProcessor.A3_BAR_CODE_INFO_INS;
//								data[data.length-2]=(byte)0x0A;;
//								data[data.length-1]=(byte)0x0D;
                        sendDataToClent(txxx);
                        sendLis(LisDataV2.buildSampleIDreceiveSucess());
                        break;
                }

            }


            Log.d("", "lis do finish,bufferDataLen:" + bufferDataLen + ",frameLen:" + frameLen);
            //移动数据位置，将已处理数据位置
            bufferDataLen -= frameLen;
            if (bufferDataLen > 0) {
                System.arraycopy(buffer, frameLen, buffer, 0, bufferDataLen);
                return parseFrame1(buffer, bufferDataLen);
            } else {
                return 0;
            }
        } else { //指令不以 FF 开始 ，复制后重新查找
            bufferDataLen--;
            System.arraycopy(buffer, 1, buffer, 0, bufferDataLen);
            return parseFrame1(buffer, bufferDataLen);
        }
    }

    private byte[] buffer = new byte[512];
    private int bufferDataLen = 0;//读取计数
    private Runnable readRunnable = new Runnable() {

        @Override
        public void run() {
            // TODO Auto-generated method stu
            //35
            HiproConf.MyLog("E", "BV2", "start  run data");
            while (isReading) {
                if (readList.size() > 0) {
                    byte[] data = readList.get(0);
                    readList.remove(0);
                    System.arraycopy(data, 0, buffer, bufferDataLen, data.length);
                    bufferDataLen += data.length;
                    Log.d(TAG, "ReadThread  read Count:" + data.length + "  read data:" + BluetoothLeService.Bytes2HexString(data) + "station:" + bufferDataLen);
                    try {
                        bufferDataLen = parseFrame1(buffer, bufferDataLen);//处理当前读取数据，获取下次存放位置
                    } catch (Exception ex) {
                        Log.d("ReadThread Error", "ReadThread Error  data:" + BluetoothLeService.Bytes2HexString(data) + "station:" + bufferDataLen);
                        ex.printStackTrace();
                    }
                    //bufferDataLen = parseData(buffer,bufferDataLen);
                } else {
                    try {
                        Thread.sleep(10);
                    } catch (InterruptedException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }

            }
        }
    };

    private int parseData(byte[] data, int bufferDataLen) {
        if (bufferDataLen < 2) return bufferDataLen;
        int start = 0;
        int end = -1;
        while (start <= (bufferDataLen - 1)) {
            end = getEnd(buffer, start);
            if (end == -1) {    //未找到指令
                start++;
                continue;
            } else if (end <= bufferDataLen) {
                //字节不足
                return bufferDataLen;

            } else {            //处理已找到指令
                byte[] temp = new byte[end - start + 1];
                System.arraycopy(data, start, temp, 0, end - start + 1);
                int result = doData(temp);
                if (result != -1) {
                    System.arraycopy(data, end + 1, data, 0, bufferDataLen - end);
                    bufferDataLen = bufferDataLen - end + 1;
                    start = 0;
                } else {
                    start++;
                }
                continue;
            }
        }
        return bufferDataLen;
    }

    private int getEnd(byte[] readData, int position) {
        if ((readData[position] & 0xff) == 0xFF) {
            int insCode = 0xff & readData[position + 1];
            int length = A3BLEProcessor.getFrameLen(insCode, buffer, bufferDataLen);
            return position + length - 1;
        }
        return -1;
    }

    private int doData(byte[] data) {
        int insCode = 0xff & buffer[1];

        Log.e("", "收到指令");
        switch (insCode) {
            case A3BLEProcessor.A3_BAR_CODE_INFO_INS: {
                if (HiproConf.barCodeAllReceive) {
                    sendDataToClent(data);
                } else {
                    String cName = "";
                    cName = new String(data, data.length - 5, 3);
                    if (HiproConf.channelList.contains(cName)) {
                        byte[] data1 = new byte[data.length - 3];
                        System.arraycopy(data, 0, data1, 0, data.length - 3);
                        data1[data1.length - 2] = data[data.length - 2];
                        data1[data1.length - 1] = data[data.length - 1];
                        sendDataToClent(data);
                    }
                }
                break;
            }
            case A3BLEProcessor.A3_GET_CHANNELS_BACK: {

                mBluetoothLeService.set_isConnecting(true);

//					if(canHandInterrupt)
//					checkBLEConnStateThread.interrupt();

                //if(mBluetoothLeService.get_isConnecting()){
                if (isConnecting) {
                    getChannels(data);
                    //发送通道连接成功消息
                    sendToClent(BLE_CONN_SUCESS, 0, 0, null);
                } else {
                    Log.d(TAG, "doData   连接状态监控4");

                }
                break;
            }
            case LisDataV2.HANDLE_RECEIVE:   //Lis握手指令
            {
                byte[] bx = LisDataV2.buidHand();
                sendLis(bx);
                break;
            }
            case LisDataV2.CHECK_CHANNEL_RECEIVE: //获取通道信息
            {
                int count = HiproConf.channelTestStateMap.size();
                if (HiproConf.channelTestStateMap.containsKey(SelfCheckActivity.CHANNEL_LIS_NAME))
                    count--;
                if (HiproConf.channelTestStateMap.containsKey(SelfCheckActivity.CHANNEL_PRINTER_NAME))
                    count--;
                Iterator<Entry<String, TestChannel>> iter = HiproConf.channelTestStateMap.entrySet().iterator();
                byte[] b = new byte[count];
                count = 0;
                while (iter.hasNext()) {
                    Entry<String, TestChannel> entry = iter.next();
                    TestChannel tc = entry.getValue();
                    if (tc.channelName.equals(SelfCheckActivity.CHANNEL_LIS_NAME) || tc.channelName.equals(SelfCheckActivity.CHANNEL_PRINTER_NAME))
                        continue;
                    b[count] = A3BLEProcessor.passAdress(tc.channelName);
                    count++;
                }
                byte[] bx = LisDataV2.buildChannelInfo(b);
                sendLis(bx);
                break;
            }
            case LisDataV2.SAMPLE_ID_RECEIVE:    //下发编号
            {
                sendChannelInstruction(SelfCheckActivity.CHANNEL_LIS_NAME, LisDataV2.SAMPLE_ID_RECEIVE, data);//处理接收完成字节数
                break;
            }
            default: {

                int frameLen = A3BLEProcessor.getFrameLen(insCode, data, data.length);
                String channel = A3BLEProcessor.geChannelName(insCode, data, frameLen);//获取通道名称

                int endstatude = A3BLEProcessor.getDataEnd(insCode);//返回校验数据未尾位置
                //校验
                if (data[frameLen - endstatude + 1] != A3BLEProcessor.chenk_byte(data, 1, frameLen - endstatude)) {
                    return -1;

                } else {

                    byte addr = A3BLEProcessor.passAdress(channel);//获取通道地址
                    //数据较验成功，发送校验成功指令
                    READ_DATA_SUCESS[1] = addr;
                    READ_DATA_SUCESS[19] = A3BLEProcessor.chenk_byte(READ_DATA_SUCESS, 1, 18);
                    sendDataToClent(data);
                }

            }
        }
        return 0;
    }


    /////解析数据
    private int parseFrame1(byte[] buffer, int bufferDataLen) {
        if (bufferDataLen < 2) return bufferDataLen;
        int hand = buffer[0] & 0xff;
        //判断指令头
        if (hand == 0xFF) {
            LogUtil.i("ondatacome     ", "parseFrame1");

            //获取当前指令
            int insCode = 0xff & buffer[1];
            Log.e(TAG, "incode:" + insCode);
            //根据指令获取所需长度
            int frameLen = A3BLEProcessor.getFrameLen(insCode, buffer, bufferDataLen);
            Log.e(TAG, "frameLen:" + frameLen);
            //1.变长帧未结束，2.固定长度帧数据不足
            if (frameLen == -1 || frameLen > bufferDataLen) return bufferDataLen;
            //未找到指令
            if ((frameLen == -2)) return 0;


            //找到符合处理条件的指令
            {
                byte[] data = new byte[frameLen];
                //复制接收检测到的本条数据，处理本条指令
                System.arraycopy(buffer, 0, data, 0, frameLen);

                Log.d(TAG, "parseFrame1  Received  Data:" + BluetoothLeService.Bytes2HexString(data) + ",Length:" + data.length + ",isSetChannel:" + isSetChannel);

                /**
                 * 数据处理部分：
                 * 1、握手协议，检测通道
                 * 2、将接收到数据根据通道名称发送出去
                 * */

                //获取版本号、仪器编号
                if (insCode == A3BLEProcessor.GET_INS_VER_CODE && (!isSetChannel)) {
                    //11个字节仪器版本号（ASCII码）
                    //校验数据
                    if (data[18] == A3BLEProcessor.chenk_byte(data, 1, 17)) {
                        //除头尾校验和，，还剩17个字节  包含指令的数据
                        //if(mBluetoothLeService.get_isConnecting()){
                        if (isConnecting) {
                            String s = new String(data, 2, 11);////仪器版本号
                            /////////////////////////////////////////////////////////////
                            boolean b = true;
                            for (int i = 13; i <= 15; i++) {
                                if (!((data[i] >= 0x30) && (data[i] <= 0x39))) {
                                    b = false;
                                }
                            }
                            if (b) {
                                HiproConf.setHDVerSion(("V" + (char) data[13]) + "." + ((char) data[14]) + "." + ((char) data[15]));
                            }

                            Log.e("VER", "硬件版本号：" + HiproConf.getHDVerSion() + ",cmp:" + ("1.0.3".compareTo(HiproConf.getHDVerSion())));
                            //如果版本号位14位版本，获取后半部分
                            if ("1.0.3".compareTo(HiproConf.getHDVerSion()) >= 0) {
                                //取12、13位仪器编号
                                s = s + new String(data, 16, 2);
                                LogUtil.i("devicecode     ", s);
                                HiproConf.setInsNoAll(s);
                                byte[] data2 = new byte[20];
                                Arrays.fill(data2, (byte) 0x00);
                                data2[0] = (byte) 0xFF;
                                data2[1] = (byte) 0X54;
                                data2[19] = 0x54;
                                write(data2);
                            } else {
                                //11为仪器编号，判断是否迈普瑞转发
                                if (HiproConf.bluetoothVer == 0) {
                                    try {
                                        String file = FileReadWrite.readFile(FileReadWrite.getConfigFileName(this) + File.separator + "InsNo.text", this);
                                        if (file != null && file.length() > 0) {
                                            s = file;
                                        }
                                    } catch (IOException e) {
                                        e.printStackTrace();
                                    }
                                }
                                HiproConf.setInsNo(s);
                                LogUtil.i("VER", "insNo0:" + s);
                                String temp = HiproConf.getInsNo().substring(4, 6);
                                LogUtil.i("VER", "insNo2:" + temp);
                                if (temp.substring(1).equals("8")) {
                                    HiproConf.InsNo5 = temp.substring(0, 1);
                                    HiproConf.setInsNo(HiproConf.getInsNo().substring(0, 4) + "08" + HiproConf.getInsNo().substring(6));
                                    HiproConf.isPushData = true;
                                    HiproConf.InsNoSHow = HiproConf.getInsNo().substring(0, 4) + HiproConf.InsNo5 + "3" + HiproConf.getInsNo().substring(6);
                                } else {
                                    HiproConf.isPushData = false;
                                    HiproConf.InsNoSHow = null;
                                }

//                                if (HiproConf.getInsNo().substring(5, 6).equals("8")) {
//                                    HiproConf.isPushData = true;
//                                } else {
//                                    HiproConf.isPushData = false;
//                                }
                            }

                            try {
                                s = new BluetoothBug().dealWithMCode(HiproConf.getInsNo().getBytes("utf-8"));
                                HiproConf.setInsNo(s);
                                SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(context);
                                sp.edit().putString(HiproConf.InsNo_Key, s.trim()).commit();

                            } catch (UnsupportedEncodingException e) {
                                e.printStackTrace();
                            }

                            Log.e("VER", "仪器编号：" + HiproConf.getInsNo() + " ,硬件版本号：" + HiproConf.getHDVerSion());
                            Log.e("VER", "软件版本号：" + PackageTool.getAppVersion(context));
                            SpUtils.put(HiproApplication.mContext, Defaultconstant.GETINSNO, HiproConf.getInsNo());


                            LogUtil.d("VER", (String) SpUtils.get(HiproApplication.mContext, Defaultconstant.GETINSNO, ""));


                        } else {
                            Log.d(TAG, "返回时间：" + System.currentTimeMillis());
                            mBluetoothLeService.set_isConnecting(true);
                        }
                    } else {
                        //处理当前字节
                        frameLen = 1;
                    }
                } else if (insCode == A3BLEProcessor.GET_INS_VER_CODE1) {
                    //0x54    14字节仪器编号
                    try {
                        String s = new String(data, 2, 14, "utf-8");//14个字节仪器编号

                        ////////////////////////////////////////////////////////////////////////////////////////////////////
                        s = new BluetoothBug().dealWithMCode(s.getBytes("utf-8"));

                        ///////////////////////////////////////////////////////////////////////////////////////////////////////

                        s = HiproConf.getInsNoAll() + s.trim();
                        HiproConf.setInsNoAll(s);
                        Log.e("VER", "设备编号1：" + HiproConf.getInsNoAll() + " ,硬件版本号1：" + HiproConf.getHDVerSion());
                        //如果使用段编号模式
                        if (!HiproConf.longInsNoMod) {
                            Log.d("", "s:" + s);
                            String temp = s.substring(0, 6);
                            Log.d("", "temp1:" + temp);
                            String temp2 = s.substring(12, 12 + 5);
                            Log.d("", "temp2:" + temp2);
                            temp = temp + temp2;
                            HiproConf.setInsNo(temp);
                        }

                        Log.e("VER", "仪器编号2：" + HiproConf.getInsNo() + " ,硬件版本号2：" + HiproConf.getHDVerSion());
                    } catch (Exception ex) {
                        Log.e("", "样本编号异常：" + ex.getMessage());
                    }

//					if(s.length()==14) {
//						String s1 =s.substring(0, 6)+s.substring(9);
//						HiproConf.setInsNo(s1);
//					}else {
//						HiproConf.setInsNo(s);
//					}

                } else if ((insCode == A3BLEProcessor.SanSHe_A0_Back) ||
                        ((insCode == A3BLEProcessor.SanSHe_A1_Back)) ||
                        ((insCode == A3BLEProcessor.SanSHe_A2_back)) ||
                        ((insCode == A3BLEProcessor.XiGuang_A0_A3_Back)) ||
                        ((insCode == A3BLEProcessor.XiGuang_A4_A5_back)) ||
                        ((insCode == A3BLEProcessor.ReadPar_back))
                ) {
                    //设置曲线返回
                    switch (insCode) {
                        case A3BLEProcessor.SanSHe_A0_Back:
                        case A3BLEProcessor.SanSHe_A1_Back:
                        case A3BLEProcessor.SanSHe_A2_back:
                        case A3BLEProcessor.XiGuang_A0_A3_Back:
                        case A3BLEProcessor.XiGuang_A4_A5_back:
                            Log.e("getpar", "getpar,操作完成");
                            MyService.setIsSetingFinish(1, "0");
                            break;
                        case A3BLEProcessor.ReadPar_back:
                            StringBuilder stem = new StringBuilder();

                            Log.e("getpar", "getpar,back:" + BluetoothLeService.Bytes2HexString(data));
                            System.arraycopy(data, 2, parData, parCount, 12);
                            parCount = parCount + 12;
                            if (parCount == 48) {
                                double dtemp;
                                float ftemp;
                                int idxtemp = 0;
                                byte[] btemps = new byte[4];
                                stem.append("xiguang:");
                                //吸光A0
                                System.arraycopy(parData, idxtemp, btemps, 0, 4);
                                dtemp = NumberConver.getFloat(btemps, 0);
                                stem.append(dtemp + ",");
                                idxtemp = idxtemp + 4;
                                //吸光A1
                                System.arraycopy(parData, idxtemp, btemps, 0, 4);
                                dtemp = NumberConver.getFloat(btemps, 0);
                                stem.append(dtemp + ",");
                                idxtemp = idxtemp + 4;
                                //吸光A2
                                System.arraycopy(parData, idxtemp, btemps, 0, 4);
                                dtemp = NumberConver.getFloat(btemps, 0);
                                stem.append(dtemp + ",");
                                idxtemp = idxtemp + 4;

                                //吸光A3
                                System.arraycopy(parData, idxtemp, btemps, 0, 4);
                                dtemp = NumberConver.getFloat(btemps, 0);
                                stem.append(dtemp + ",");
                                idxtemp = idxtemp + 4;

                                //吸光A4
                                System.arraycopy(parData, idxtemp, btemps, 0, 4);
                                dtemp = NumberConver.getFloat(btemps, 0);
                                stem.append(dtemp + ",");
                                idxtemp = idxtemp + 4;

                                //吸光A5
                                System.arraycopy(parData, idxtemp, btemps, 0, 4);
                                dtemp = NumberConver.getFloat(btemps, 0);
                                stem.append(dtemp + ";");
                                idxtemp = idxtemp + 4;


                                btemps = new byte[8];
                                stem.append(";sanshe:");
                                //散射 A0
                                System.arraycopy(parData, idxtemp, btemps, 0, 8);
                                dtemp = NumberConver.getDouble(btemps, 0);
                                stem.append(dtemp + ",");
                                idxtemp = idxtemp + 8;
                                //散射 A1
                                System.arraycopy(parData, idxtemp, btemps, 0, 8);
                                dtemp = NumberConver.getDouble(btemps, 0);
                                stem.append(dtemp + ",");
                                idxtemp = idxtemp + 8;
                                //散射 A2
                                System.arraycopy(parData, idxtemp, btemps, 0, 8);
                                dtemp = NumberConver.getDouble(btemps, 0);
                                stem.append(dtemp);
                                idxtemp = idxtemp + 8;

                                Log.e("getpar", "getpar,pars:" + stem.toString());
                                parCount = 0;
                                MyService.setIsSetingFinish(1, stem.toString());
                            }
                            break;
                    }


                } else if ((insCode == 0x32) || ((insCode == 0x3D) && (!HiproConf.isSelfCheck))) {

                    if (HiproConf.getHDVerSion() != null) {
                        //校验数据
                        if (data[19] == A3BLEProcessor.chenk_byte(data, 1, 18)) {
                            //synchronized (Plock)
                            {
                                writeSucceBack.add(data);
                                //Log.e(TAG,"打印指令返回："+BluetoothLeService.Bytes2HexString(data) + "time:" + System.currentTimeMillis() + "writeSucceBack count:"+(writeSucceBack.size()+1));
                            }
                        } else {
                            frameLen = 1;
                        }
                    }
                }
                //一维码处理
                else if (A3BLEProcessor.A3_BAR_CODE_INFO_INS == insCode) {
                    //Log.e(TAG,"HiproConf.barCodeAllReceive:"+HiproConf.barCodeAllReceive);
                    if (HiproConf.barCodeAllReceive) {
//								Log.e(TAG,"receive data,一维码:"+BluetoothLeService.Bytes2HexString(data));
//								broadcastUpdate(ACTION_DATA_AVAILABLE, data);

                        String s = ByteUtil.bytes2HexStr(data);

                        LogUtil.i(oncodeData, "barCodeAllReceive----" + s);

                        if (StrValidate.isLetterDigit(s)) {  //匹配正则
                            LogUtil.i(oncodeData, "isLetterDigit" + Thread.currentThread().getId() + "data----" + s);
                            sendDataToClent(data);
                        } else {
                            new BackMainThread().backMain("一维码错误含有特殊符号，请重新扫码！");
                            LogUtil.i("isLetterDigit", "一维码含有特殊符号");
                        }
                    } else {
                        String cName = "";
                        cName = new String(data, data.length - 5, 3);
                        if (HiproConf.isNoFirst) {
                            cName = cName.toCharArray()[2] + cName.toCharArray()[0] + cName.toCharArray()[1] + "";
                        }
//								Log.e(TAG,"log cName:"+cName  +"  data:"+BluetoothLeService.Bytes2HexString(data));

                        if (HiproConf.channelList.contains(cName)) {

                            byte[] data1 = new byte[data.length - 3];
                            System.arraycopy(data, 0, data1, 0, data.length - 3);
                            data1[data1.length - 2] = data[data.length - 2];
                            data1[data1.length - 1] = data[data.length - 1];
//										Log.e(TAG,"receive data,一维码:"+BluetoothLeService.Bytes2HexString(data1));
                            //broadcastUpdate(ACTION_DATA_AVAILABLE, data);

                            if (StrValidate.isLetterDigit(ByteUtil.bytes2HexStr(data1))) { //匹配正则

                                sendDataToClent(data);
                            }


                        }
                        //Log.e(TAG,"HiproConf.channelList.contains(cName):"+HiproConf.channelList.contains(cName));
                    }
                } else if (A3BLEProcessor.A3_GET_CHANNELS_BACK == insCode) {
                    //sendChannelInstruction(channel, insCode, data);//处理接收完成字节数
                    //Log.e(TAG,"receive data,返回通道:"+BluetoothLeService.Bytes2HexString(data));
                    getChannels(data);

                    //sendDataToClent(data);

                } else if (LisDataV2.isLisCode(insCode)) {
                    Log.e("", "Lis 数据");
                    byte[] bx;
                    switch (insCode) {
                        case LisDataV2.HANDLE_RECEIVE:   //Lis握手指令
                            bx = LisDataV2.buidHand();
                            sendLis(bx);
                            break;
                        case LisDataV2.CHECK_CHANNEL_RECEIVE: //获取通道信息
                            int count = HiproConf.channelTestStateMap.size();
                            if (HiproConf.channelTestStateMap.containsKey(SelfCheckActivity.CHANNEL_LIS_NAME))
                                count--;
                            if (HiproConf.channelTestStateMap.containsKey(SelfCheckActivity.CHANNEL_PRINTER_NAME))
                                count--;
                            Iterator<Entry<String, TestChannel>> iter = HiproConf.channelTestStateMap.entrySet().iterator();
                            byte[] b = new byte[count];
                            count = 0;
                            while (iter.hasNext()) {
                                Entry<String, TestChannel> entry = iter.next();
                                TestChannel tc = entry.getValue();
                                if (tc.channelName.equals(SelfCheckActivity.CHANNEL_LIS_NAME) || tc.channelName.equals(SelfCheckActivity.CHANNEL_PRINTER_NAME))
                                    continue;
                                b[count] = A3Processor.passAdress(tc.channelName);
                                count++;
                            }
                            bx = LisDataV2.buildChannelInfo(b);
                            sendLis(bx);
                            break;
                        case LisDataV2.SAMPLE_ID_RECEIVE:    //下发编号
                            //sendChannelInstruction(SelfCheckActivity.CHANNEL_LIS_NAME, LisDataV2.SAMPLE_ID_RECEIVE, data);//处理接收完成字节数

                            byte[] txxx = new byte[data.length - 1];
                            txxx[0] = (byte) 0xFF;
                            txxx[1] = data[0] = (byte) A3BLEProcessor.A3_BAR_CODE_INFO_INS;
                            System.arraycopy(data, 2, txxx, 2, 15);
                            txxx[txxx.length - 2] = (byte) 0x0A;
                            txxx[txxx.length - 1] = (byte) 0x0D;


//								data[0] =(byte) 0xFF;
//								data[1] = (byte)A3BLEProcessor.A3_BAR_CODE_INFO_INS;
//								data[data.length-2]=(byte)0x0A;;
//								data[data.length-1]=(byte)0x0D;
                            sendDataToClent(txxx);
                            sendLis(LisDataV2.buildSampleIDreceiveSucess());
                            break;
                    }

                } else { //处理其他指令

                    //Log.d(TAG,"处理数据:  "+BluetoothLeService.Bytes2HexString(data) +"  " +getStringss(data));
                    String channel = A3BLEProcessor.geChannelName(insCode, data, frameLen);//获取通道名称
                    if (channel == null) return 0;

                    //如果在设定通道内
                    if (HiproConf.channelList.contains(channel) || "Control".equals(channel)) {
                        int endstatude = A3BLEProcessor.getDataEnd(insCode);//返回校验数据未尾位置


                        Log.e(TAG, "返回校验数据未尾位置:" + endstatude);
                        Log.e(TAG, "frameLen:" + frameLen);
                        Log.e(TAG, "data[frameLen - endstatude + 1]:" + data[frameLen - endstatude + 1]);
                        Log.e(TAG, "A3BLEProcessor.chenk_byte(data, 1, frameLen - endstatude)]:" + A3BLEProcessor.chenk_byte(data, 1, frameLen - endstatude));
                        if (data[frameLen - endstatude + 1] != A3BLEProcessor.chenk_byte(data, 1, frameLen - endstatude) && !isShowTestMod) {
                            //Log.e(TAG,"数据校验失败  收到数据：" + BluetoothLeService.Bytes2HexString(data) +" , 校验和："+A3BLEProcessor.chenk_byte(data,1,frameLen-endstatude)) ;
                            //return 0;

//											bufferDataLen --;
//											System.arraycopy(buffer, 1, buffer, 0, bufferDataLen);
////											System.out.println("data receive5");
//											return parseFrame1(buffer,bufferDataLen);
                            frameLen = 1;
                        }
//										if(data[data.length-endstatude]==A3BLEProcessor.chenk_byte(data, 1, data.length-endstatude-1)){
//											Log.e(TAG,"数据校验失败");
//											return 0;
//										}
                        else {
                            byte addr = A3BLEProcessor.passAdress(channel);//获取通道地址
//											Log.d(TAG,"接收数据ChannelName:"+channel+" Address:"+addr);
                            //数据较验成功，发送校验成功指令
                            READ_DATA_SUCESS[1] = addr;
                            READ_DATA_SUCESS[19] = A3BLEProcessor.chenk_byte(READ_DATA_SUCESS, 1, 18);
                            //writeData(READ_DATA_SUCESS);
                            //if((insCode!=A3BLEProcessor.A3_GET_BARCODE_BACK)&&(insCode!=A3BLEProcessor.A3_GET_RESULT_BACK))
                            //Log.e(TAG, "read Data Time: " + (System.currentTimeMillis() - sendtime));
                            //if(isReceiveback)
                            //((MyService)	context).writeData(READ_DATA_SUCESS);
//												Message msg = clentHandler.obtainMessage(MyService.DEVICE_DATA_SEND, READ_DATA_SUCESS);
//												msg.sendToTarget();

                            sendDataToClent(data);
                        }
                    }
                }
            }
            Log.d("", "do finish,bufferDataLen:" + bufferDataLen + ",frameLen:" + frameLen);
            //移动数据位置，将已处理数据位置
            bufferDataLen -= frameLen;
            if (bufferDataLen > 0) {
                System.arraycopy(buffer, frameLen, buffer, 0, bufferDataLen);
                return parseFrame1(buffer, bufferDataLen);
            } else {
                return 0;
            }
        } else { //指令不以 FF 开始 ，复制后重新查找
            bufferDataLen--;
            System.arraycopy(buffer, 1, buffer, 0, bufferDataLen);
            return parseFrame1(buffer, bufferDataLen);
        }


    }

    public void sendChannelInstruction(String channelName, int insCode,
                                       byte[] data) {
        //发送接收到数据信息的消息
//	Message msg = srvHandler.obtainMessage(MSG_FORWARD_TEST_DATA);
//
//	Bundle extraData = new Bundle();
//	extraData.putInt("ins_code", insCode);
//	extraData.putString("channel_name", channelName);
//	extraData.putByteArray("ins_data", data);
//	msg.setData(extraData);
//	msg.sendToTarget();

    }

    //向Lis发送数据
    public void sendLis(byte[] lisData) {
        LogUtil.i("ondatacome     ", "sendLis");
        if (HiproConf.bluetoothVer != 0) {
            byte[] buff = lisData;

            //byte buff[] = new byte[lisData.length-2];
            //System.arraycopy(lisData,2, buff, 0, lisData.length-2);

            int len = buff.length;
            int[] lens = dataSeparate(len, 15);
            //System.out.println("writeData Len[0]:"+lens[0] +"  lens[1]:"+lens[1]);

            int count = 1;
            for (int i = 0; i < lens[0]; i++) {

                byte[] send = new byte[21];
                Arrays.fill(send, (byte) 0x00);

                send[0] = (byte) 0xFF;
                send[1] = 0x31;
                send[2] = (byte) 0xbd;
                System.arraycopy(buff, i * 15, send, 3, 15);
                send[18] = (byte) (count & 0xFF);
                send[19] = A3BLEProcessor.chenk_byte(send, 1, send.length - 3);

                writeData(send);
                System.out.println("Lis data " + BluetoothLeService.Bytes2HexString(send));
                count++;
            }
            if (lens[1] != 0) {
                byte[] send = new byte[21];
                Arrays.fill(send, (byte) 0x00);
                send[0] = (byte) 0xFF;
                send[1] = 0x31;
                send[2] = (byte) 0xbd;
                send[18] = (byte) (count & 0xFF);
                System.arraycopy(buff, 15 * lens[0], send, 3, lens[1]);
                send[19] = A3BLEProcessor.chenk_byte(send, 1, send.length - 3);
                writeData(send);
                System.out.println("Lis data " + BluetoothLeService.Bytes2HexString(send));
                count++;
            }

            {
                byte[] send = new byte[21];
                Arrays.fill(send, (byte) 0x00);
                send[0] = (byte) 0xFF;
                send[1] = 0x33;
                send[2] = (byte) 0xbd;
                send[3] = (byte) (buff.length & 0xFF);
                send[18] = (byte) ((count - 1) & 0xFF);
                send[19] = A3BLEProcessor.chenk_byte(send, 1, send.length - 3);
                System.out.println("Lis data " + BluetoothLeService.Bytes2HexString(send));
                writeData(send);
            }
        } else {
            byte[] tempx = new byte[lisData.length + 2];
            tempx[0] = (byte) 0xFF;
            tempx[1] = 0x24;
            System.arraycopy(lisData, 0, tempx, 2, lisData.length);
            mylis.WriteData(tempx);
        }
    }

    public int[] dataSeparate(int len, int per) {
        int[] lens = new int[2];
        lens[0] = len / per;
        lens[1] = len - per * lens[0];
        return lens;
    }


    private void sendDataToClent(byte[] data) {

        //处理发送过来的数据
        int code = data[1] & 0xFF;
        String sx = "";
        String channel = "";
        if (HiproConf.isTestBluetooth) {
            if ((code != A3BLEProcessor.A3_BAR_CODE_INFO_INS) && (code != A3BLEProcessor.A3_GET_CHANNELS_BACK))
                channel = A3BLEProcessor.geChannelName(code, data, data.length);

            switch (code) {
                case A3BLEProcessor.A3_BAR_CODE_INFO_INS:
                    sx = "收到一维码：" + new String(data, 2, data.length - 4);

                    LogUtil.i("onecode", sx);

                    break;
                case A3BLEProcessor.A3_GET_CHANNELS_BACK:
                    //getChannels(data);
                    sx = "返回通道数";
                    break;
                case A3BLEProcessor.A3_HANDSHAKE_INS:
                    sx = "通道：" + channel + " " + " 指握手令";
                    break;
                case A3BLEProcessor.A3_HANDSHAKE_OK_INS:
                    sx = "通道：" + channel + " " + "握手成功";
                    break;

                case A3BLEProcessor.A3_CUVETTE_EXISTED_INS:
                    sx = "通道：" + channel + " " + "反应杯放入";
                    break;
                case A3BLEProcessor.A3_TEST_RESULT_INS:
                    sx = "通道：" + channel + " " + "测试结果";
                    break;
                case A3BLEProcessor.A3_QR_CODE_ERROR_INS:
                    sx = "通道：" + channel + " " + " 二维码错误";
                    break;
                case A3BLEProcessor.A3_TAKE_CUVETTE_OUT_INS:
                    sx = "通道：" + channel + " " + "取出反应杯";
                    break;
                case A3BLEProcessor.A3_PUT_CUVETTE_IN_INS:
                    sx = "通道：" + channel + " " + "通道空闲";
                    break;
                case A3BLEProcessor.A3_CANCEL_TEST_INS:
                    sx = "通道：" + channel + " " + "取消测试";
                    break;
                case A3BLEProcessor.A3_MIXED_ERROR_INS:
                    sx = "通道：" + channel + " " + " 混匀错误";
                    break;
                case A3BLEProcessor.A3_PRESSED_ERROR_INS:
                    sx = "通道：" + channel + " " + "下压错误";
                    break;
                case A3BLEProcessor.A3_TEMPERATURE_LOW_INS:
                    sx = "通道：" + channel + " " + "反应杯温度低";
                    break;
                case A3BLEProcessor.A3_SAMPLE_TEST_TEMPERATURE_INS:
                    sx = "通道：" + channel + " " + "测试温度";
                    break;
                case A3BLEProcessor.A3_CONTROL_START_INS:
                    sx = "通道：" + channel + " " + "进入质控";
                    break;
                case A3BLEProcessor.A3_CONTROL_START_OK_INS:
                    sx = "通道：" + channel + " " + "进入质控";
                    break;
                case A3BLEProcessor.A3_CONTROL_RATIO_RET_INS:
                    sx = "通道：" + channel + " " + "质控系数下发反馈";
                    break;
                case A3BLEProcessor.A3_SAMPLE_RATIO_RET_INS:
                    sx = "通道：" + channel + " " + "系数下发反馈";
                    break;
                case A3BLEProcessor.A3_GET_RESULT_BACK:
                    sx = "通道：" + channel + " " + "再次测试结果返回";
                    break;
                case A3BLEProcessor.A3_PAINT_ID_SEND_SUCESS:
                    sx = "通道：" + channel + " " + "下发编号";
                    break;
                case A3BLEProcessor.A3_CUP_OUT_ERROR:
                    sx = "通道：" + channel + " " + "试杯拔出错误";
                    break;
                case A3BLEProcessor.A3_QR_CODE_INFO_INS:
                    sx = "通道：" + channel + " " + "样本测试二维码信息   " + data[16];
                    break;

                default:
                    channel = A3BLEProcessor.geChannelName(code, data, data.length);
                    sx = BluetoothLeService.Bytes2HexString(data);
            }
            sx = sx + " ，数据：" + BluetoothLeService.Bytes2HexString(data);
            //sendData(code,"C01",sx);

        } else {
            Log.e("sendToClent", "send to clent  data:" + BluetoothLeService.Bytes2HexString(data));
            LogUtil.i("oncodeData", "111" + ByteUtil.bytes2HexStr(data));
            //走这里
            sx = "";
            switch (code) {
                case A3BLEProcessor.A3_BAR_CODE_INFO_INS:
                    sendData(code, "C01", data, sx);
                    break;
                case A3BLEProcessor.A3_GET_CHANNELS_BACK:
                    getChannels(data);
                    break;
                default:
                    channel = A3BLEProcessor.geChannelName(code, data, data.length);
                    sendData(code, channel, data, sx);//一维码处理
                    break;
            }

        }

    }

    private void startRead() {
        if (isReading) {
            isReading = false;
            if ((readThread != null))
                readThread.interrupt();
            if (lisThread != null)
                lisThread.interrupt();

        }

        if (clentHandler != null) {
            clentHandler.postDelayed(new Runnable() {
                @Override
                public void run() {
                    // TODO Auto-generated method stub
                    isReading = true;
                    readThread = new Thread(readRunnable);
                    readThread.start();

                    lisThread = new Thread(lisRunnable);////
                    lisThread.start();
                }
            }, 2000);
        }

    }

    private Runnable writeRunnable = new Runnable() {    /////////////////////发送数据到下位机
        @Override
        public void run() {
            /**35*/
            Log.d("bleconn", "write state , 发送队列开始运行");
            boolean isSendBack = false;
            HiproConf.MyLog("E", "BV2", "write list run ,isConnecting:" + isConnecting);
            while (isConnecting) {
                int waitTime = 50;
                {
                    {
                        if (!(writeList.size() > 0)) continue;
                        byte[] data = writeList.get(0);
                        boolean isSend = false;
                        if ((data.length == 1) && data[0] == 0x00) isSend = true;
                        HiproConf.MyLog("E", "BV2", "writelist get(0)");
                        {
                            write(data);
                            writeList.remove(0);
                        }

                        //延时
                        try {
                            Thread.sleep(WRITE_SPEED);
                        } catch (InterruptedException e) {
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }

                    }
                }

            }

        }
    };

    public boolean isHave(Vector<byte[]> v, byte[] b) {
        boolean bd = false;
        int i = v.size();
        if (v.size() < 1) return false;

//	for(byte[] bx : v){
//		bd = Arrays.equals(bx, b);
//		if(bd)
//		{
//			v.remove(bx);
//			break;
//		}
//	}
        for (int j = 0; j < i; j++) {
            byte[] bx = v.get(j);
            bd = Arrays.equals(bx, b);
            if (bd) {
                v.remove(j);
                break;
            }
        }

        return bd;
    }

    private class Printer extends Thread {
        private Handler h;
        private byte[] data;
        public List<byte[]> dataList;
        private int speed;

        public Printer() {
            //System.out.println(" new Print Data");
        }

        public Printer(Handler h, byte[] d) {
            this.h = h;
            this.data = d;
        }

        public Printer(Handler h, byte[] d, int speed) {
            this.h = h;
            this.data = d;
            this.speed = speed;
        }

        public Printer(Handler h, List<byte[]> dataList, int speed) {
            this.h = h;
            this.dataList = dataList;
            this.speed = speed;
        }

        //	@Override
//	public void run() {
//		// TODO Auto-generated method stub
//		super.run();
//		Log.e("run", "send print list  speed :" +speed);
//
////		while(!isClosing){
////			if(dataList.size()>0){
////				byte[] buff =dataList.get(0);
////				dataList.remove(0);
////				sendPrintData(buff);
////
////			}else{
////				try {
////					Thread.sleep(1000);
////				} catch (InterruptedException e) {
////					// TODO Auto-generated catch block
////					e.printStackTrace();
////				}
////			}
////		}
//
//		synchronized(PRINTLOCK){
//
//			for(int i =0;i<dataList.size();i++){
//				byte[] buff =dataList.get(i);
//				//dataList.remove(0);
//				//Log.e("run", "send print list  No: "+i +"   print count:" +buff.length);
//				boolean isSendFinish = false;
//				while(!isSendFinish){
//					if(canWrite){
//						sendPrintData(buff);
//						isSendFinish=true;
//					}else{
////						Thread.currentThread();
////						try {
////							Thread.currentThread();
////							Thread.sleep(100);
////						} catch (InterruptedException e) {
////							// TODO Auto-generated catch block
////							e.printStackTrace();
////						}
//					}
//				}
//	//			StringBuilder s = new StringBuilder(BluetoothLeService.Bytes2HexString(buff));
////				if(s.indexOf("1D21") != -1)
//				{
////					Thread.currentThread();
////					try {
////						Thread.currentThread();
////						Thread.sleep(100);
////					} catch (InterruptedException e) {
////						// TODO Auto-generated catch block
////						e.printStackTrace();
////					}
//				}
//			}
//		}
//	}
        public int[] dataSeparate(int len, int per) {
            int[] lens = new int[2];
            lens[0] = len / per;
            lens[1] = len - per * lens[0];
            return lens;
        }

        public void sendLisData(byte[] lisData) {
            byte[] buff = lisData;

//		byte buff[] = new byte[lisData.length-2];
//		System.arraycopy(lisData,2, buff, 0, lisData.length-2);
            int len = buff.length;
            int[] lens = dataSeparate(len, 15);
            //System.out.println("writeData Len[0]:"+lens[0] +"  lens[1]:"+lens[1]);
            long no = System.currentTimeMillis();
            //int count =0 ;
            int count = 1;
            System.out.println("Lis 数据   " + no + " 分组前：  " + BluetoothLeService.Bytes2HexString(buff));

            for (int i = 0; i < lens[0]; i++) {

                byte[] send = new byte[21];
                Arrays.fill(send, (byte) 0x00);

                send[0] = (byte) 0xFF;
                send[1] = 0x31;
                send[2] = (byte) 0xbd;
                System.arraycopy(buff, i * 15, send, 3, 15);
                send[18] = (byte) (count & 0xFF);
                send[19] = A3BLEProcessor.chenk_byte(send, 1, send.length - 3);

                writeData(send);
                System.out.println("Lis 数据   " + no + "：  " + BluetoothLeService.Bytes2HexString(send));
                count++;
            }
            if (lens[1] != 0) {
                byte[] send = new byte[21];
                Arrays.fill(send, (byte) 0x00);
                send[0] = (byte) 0xFF;
                send[1] = 0x31;
                send[2] = (byte) 0xbd;
                send[18] = (byte) (count & 0xFF);
                System.arraycopy(buff, 15 * lens[0], send, 3, lens[1]);
                send[19] = A3BLEProcessor.chenk_byte(send, 1, send.length - 3);
                writeData(send);
                System.out.println("Lis 数据  " + no + "： " + BluetoothLeService.Bytes2HexString(send));
                count++;

            }

            {
                byte[] send = new byte[21];
                Arrays.fill(send, (byte) 0x00);
                send[0] = (byte) 0xFF;
                send[1] = 0x33;
                send[2] = (byte) 0xbd;
                send[3] = (byte) (buff.length & 0xFF);
                //send[18] = (byte)((count-1) & 0xFF);
                send[18] = (byte) ((10) & 0xFF);
                send[19] = A3BLEProcessor.chenk_byte(send, 1, send.length - 3);
                System.out.println("Lis 数据   last" + no + "： " + BluetoothLeService.Bytes2HexString(send));
                writeData(send);
            }


        }

        public void sendPrintData(byte[] pData) {
            //分批发送字节
            {
                System.out.println("sendPrintData time:" + System.currentTimeMillis());
                byte[] buff = pData;
                int len = buff.length;
                int[] lens = dataSeparate(len, 15);
                System.out.println("打印数据数据:" + BluetoothLeService.Bytes2HexString(pData));
                int i;
                for (i = 0; i < lens[0]; i++) {
                    byte[] send = new byte[21];
                    Arrays.fill(send, (byte) 0x00);
                    send[0] = (byte) 0xFF;
                    send[1] = (byte) 0x3D;
                    send[2] = (byte) (16);
                    send[3] = (byte) (i & 0xFF);
                    System.arraycopy(buff, i * 15, send, 4, 15);
                    send[19] = A3BLEProcessor.chenk_byte(send, 1, send.length - 3);
                    System.out.println("打印数据 No:" + i + " data: " + BluetoothLeService.Bytes2HexString(send));
                    writeData(send);

                }
                if (lens[1] != 0) {
                    byte[] send = new byte[21];

                    Arrays.fill(send, (byte) 0x00);
                    send[0] = (byte) 0xFF;
                    send[1] = (byte) 0x3D;
                    send[2] = (byte) (16);
                    send[3] = (byte) (i & 0xFF);
                    System.arraycopy(buff, 15 * lens[0], send, 4, lens[1]);
                    send[19] = A3BLEProcessor.chenk_byte(send, 1, send.length - 3);
                    System.out.println("打印数据 No:" + i + " data: " + BluetoothLeService.Bytes2HexString(send));
                    writeData(send);
                }

                {
                    byte[] send = new byte[21];
                    Arrays.fill(send, (byte) 0x00);
                    send[0] = (byte) 0xFF;
                    send[1] = 0x3D;
                    send[2] = (byte) (17);
                    send[3] = (byte) (byte) (len / 256);
                    send[4] = (byte) (len % 256);
                    send[19] = A3BLEProcessor.chenk_byte(send, 1, send.length - 3);
                    System.out.println("打印数据结束 No: " + i + " data: " + BluetoothLeService.Bytes2HexString(send));
                    writeData(send);
                }


            }
        }

//	private void sendData(byte[] dt){
//		System.out.println( "prient  sendData data:" + BluetoothLeService.Bytes2HexString(dt) + "timer:" +System.currentTimeMillis());
//		Message msg = h.obtainMessage();
//		msg.what=DEVICE_DATA_SEND;
//		msg.obj=dt;
//		msg.sendToTarget();
//	}
    }

    //每隔30s 监听蓝牙状态
    private Runnable checkBLEConnStateRun = new Runnable() {
        @Override
        public void run() {
            // TODO Auto-generated method stub

            Thread.currentThread();
            try {
                Thread.sleep(10000);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            while (!isClosing && isCheckBLE) {
                order++;
                checkBLEConnState();
                Thread.currentThread();
                try {
                    if (isCheckBLE)
                        Thread.sleep(CHECK_BLE_CONN_RATE);
                } catch (InterruptedException e) {
                    // TODO Auto-generated catch block
                    Log.d("", "  连接状态监控60");
                    e.printStackTrace();

                }
            }

        }
    };
    private Thread checkBLEConnStateThread;

    private void startCheckBle() {
        Log.d("", "监控线程开始运行,None");
//	if(checkBLEConnStateThread!=null) {
//		isCheckBLE=false;
//		checkBLEConnStateThread.interrupt();
//		checkBLEConnStateThread=null;
//		mhandler.postDelayed(new Runnable() {
//
//			@Override
//			public void run() {
//				// TODO Auto-generated method stub
//				startCheckBle();
//			}
//		}, 500);
//	}
//	Log.d("", "BLE连接监听开始");
//	isCheckBLE=true;
//	checkBLEConnStateThread = new Thread(checkBLEConnStateRun);
        //checkBLEConnStateThread.start();
    }

    private void exitCheckBle() {

        if (checkBLEConnStateThread != null) {
            isCheckBLE = false;
            checkBLEConnStateThread.interrupt();
            checkBLEConnStateThread = null;
        }
    }

    private void reconnedBLE() {
        //Log.d("", " 	clentHandler.postDelayed  连接状态监控50 ，  开始重新连接");

        try {
            connect(mDeviceAddress);
            recTime = System.currentTimeMillis();
            canInterrupt = true;
            Thread.currentThread();
            Thread.sleep(BLE_RECONNECTION_TIME_OUT);
        } catch (InterruptedException ex) {
            //Log.d("", "  连接状态监控61");
        } catch (Exception ex) {
            ex.printStackTrace();
            //Log.d("", "  连接状态监控62");
        }

        //设置为可重新开始连接
        mBluetoothLeService.setReConnecting(false);

    }

    private void checkBLEConnState() {
        //发送获取通道信息指令
        byte[] data = {(byte) 0xFF, (byte) 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3c,
                0x00};
        if (target_chara != null) {
            //Log.d("", " checkBLEConnState  连接状态监控53,recTime:"+recTime +",currtime:"+System.currentTimeMillis()+",order:"+order);
            //if(mBluetoothLeService.isReConnecting() && ((System.currentTimeMillis() -recTime) <BLE_RECONNECTION_TIME_OUT)) return;
            if (mBluetoothLeService.get_isConnecting()) {
                mBluetoothLeService.set_isConnecting(false);
                writeData(data);
                //write(data);
                //Log.d("", " checkBLEConnState  连接状态监控54  发送指令时间："+System.currentTimeMillis());
                //延时
                canHandInterrupt = true;
                try {
                    Thread.currentThread();
                    if (isCheckBLE)
                        Thread.sleep(CHECK_BLE_STATE_WAITE);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                    //Log.d("", "  连接状态监控63");
                }
                canHandInterrupt = false;

                if (mBluetoothLeService.get_isConnecting()) {
                    ;
                } else {
                    //Log.d("", " 	clentHandler.postDelayed  连接状态监控57 ，  重新连接");
                    if (isCheckBLE)
                        reconnedBLE();
                }

            } else {
                //Log.d("", " 	clentHandler.postDelayed  连接状态监控58 ，  重新连接");
                if (isCheckBLE)
                    reconnedBLE();
            }
        } else {
            //Log.d("", " 	clentHandler.postDelayed  连接状态监控59 ，  重新连接");
            if (isCheckBLE)
                reconnedBLE();
        }
        //Log.d("", " checkBLEConnState  连接状态监控3");
    }

    @SuppressLint("WrongConstant")
    private void selfcheck() {
        //设置蓝牙可被发现
//			Intent intent = new Intent(BluetoothAdapter.ACTION_REQUEST_DISCOVERABLE);
//			intent.putExtra(BluetoothAdapter.EXTRA_DISCOVERABLE_DURATION,300);
//			startActivity(intent);


        isHandle = true;
        Log.e(TAG, "device Mac:" + HiproConf.deviceMac);
        mDeviceAddress = HiproConf.deviceMac;
        if (HiproConf.bluetoothVer == 0 || !TextUtils.isEmpty(this.mDeviceAddress)) {
            connect(mDeviceAddress);
            Thread handThread = new Thread(new Runnable() {
                @Override
                public void run() {
                    // TODO Auto-generated method stub
                    //连接指令发出后，延时2S

                    try {
                        Thread.currentThread();
                        Thread.sleep(5000);
                    } catch (InterruptedException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }

                    byte[] data = {(byte) 0xFF, (byte) 0x3c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3C,
                            0x00};

                    try {
                        Thread.currentThread();
                        Thread.sleep(1000);
                    } catch (InterruptedException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    //如果连接未成功，等待
//					while(((target_chara==null) || (!isConnecting)) && isHandle ){
//						try {
//							Thread.currentThread();
//							Thread.sleep(1000);
//						} catch (InterruptedException e) {
//							// TODO Auto-generated catch block
//							e.printStackTrace();
//						}
//					}
                    HiproConf.MyLog("E", "BV2", "获取版本号+isHandle：" + isHandle);
                    //发送获取通道指令
                    if (isHandle) {




                        long sendTime = System.currentTimeMillis();
                        isQuDao=false;
                        while (System.currentTimeMillis() - sendTime < 60*10000) {

                            if(isQuDao){
                                break;
                            }
                            Message msg = Message.obtain();
                            msg.what = DEVICE_DATA_SEND;
                            msg.obj = data;
                            if (clentHandler != null) {
                                clentHandler.sendMessage(msg);
                            }
                            try {
                                Thread.currentThread();
                                Thread.sleep(3000);
                                if(isQuDao){
                                    break;
                                }
                            } catch (InterruptedException e) {
                                // TODO Auto-generated catch block
                                e.printStackTrace();
                            }
                        }




                        //byte[]	data1= {(byte)0xFF ,(byte)0x3c,};
                        data = new byte[]{(byte) 0xFF, (byte) 0x50, 0x00, 0x00, 0x00,
                                0x00, 0x00, 0x00, 0x00, 0x00,
                                0x00, 0x00, 0x00, 0x00, 0x00,
                                0x00, 0x00, 0x00, 0x00, 0x50,
                                0x00};
                        Message msg = Message.obtain();
                        msg.what = DEVICE_DATA_SEND;
                        msg.obj = data;
                        if (clentHandler != null) {
                            clentHandler.sendMessage(msg);
                        }

                    }
                }
            });
            startRead();
            handThread.start();
            return;
        }
        Toast.makeText(HiproApplication.mContext, "请在系统设置中，选择蓝牙", 1).show();
        sendToClent(BLE_SELF_CHECK_FINISH, 0, 0, null);
    }

    /**
     *  2022.8.25
     *  解决开机有时候获取通道失败的问题
     */
    private boolean isQuDao=false;
    //向客户端发送数据
    private void sendToClent(int what, int arj1, int arj2, Object obj) {
        Log.e(TAG, "send to clent message:" + what + " arj1 :" + arj1 + " arj2" + arj2 + " obj:" + obj);


        LogUtil.i("ondatacome     ", "send to clent message:" + what + " arj1 :" + arj1 + " arj2" + arj2 + " obj:" + obj);
        Log.d(TAG, "clentHome的数量：" + clentHome.size());
        for (Handler h : clentHome) {
            Message msg = new Message();
            msg.what = what;
            msg.arg1 = arj1;
            msg.arg2 = arj2;
            msg.obj = obj;
            h.sendMessage(msg);
        }
    }

    private void sendToClent(int what, Bundle b) {

        for (Handler h : clentHome) {
            Message msg = new Message();
            msg.what = what;
            msg.setData(b);
            h.sendMessage(msg);
        }
    }

    final Messenger serviceMessenger = new Messenger(clentHandler);

    /**
     * 广播接收器，负责接收BluetoothLeService类发送的数据
     */
    private final BroadcastReceiver mGattUpdateReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            final String action = intent.getAction();
            if (BluetoothLeService.ACTION_GATT_CONNECTED.equals(action))//Gatt连接成功
            {
                //更新界面，连接状态
                //updateConnectionState(status);
                System.out.println("BroadcastReceiver :" + "device connected");

                //isConnecting = true;
            } else if (BluetoothLeService.ACTION_GATT_DISCONNECTED.equals(action))//Gatt连接失败

            {
                //更新界面，连接状态
                //updateConnectionState(status);
                System.out.println("BroadcastReceiver :" + "device disconnected");
//					if(connCount <3){
//					connect(mDeviceAddress);
//					System.out.println("re Connected");
//					return;
//					}


                //sendToClent( BLE_CONN_FAILE,0,0,null);
                isConnecting = false;
                if (writeThread != null) writeThread.interrupt();
                //if(! isReconn)	reConnect();

//					clentHandler.postDelayed(
//							new Runnable() {
//								@Override
//								public void run() {
//									// TODO Auto-generated method stub
//									if(reconnCount<=3){
//									mBluetoothLeService.connect(mDeviceAddress);
//									reconnCount++;
//									}
//								}
//							}
//							,5000);


            } else if (BluetoothLeService.ACTION_GATT_SERVICES_DISCOVERED//发现GATT服务器
                    .equals(action)) {

                //获取设备的所有蓝牙服务

                //displayGattServices1(mBluetoothLeService.getSupportedGattServices());
                displayGattServices(mBluetoothLeService.getSupportedGattServices());

                System.out.println("BroadcastReceiver :" + "device SERVICES_DISCOVERED");
            } else if (BluetoothLeService.ACTION_DATA_AVAILABLE.equals(action))//有效数据
            {
                if (!isConnecting) {
                    isConnecting = true;
                    if (writeThread == null) {

                        setCanWrite(true);
                        writeThread = new Thread(writeRunnable);
                        writeThread.start();
                    }

                    if (printThread == null) {
                        printThread = new Thread(pritRunnable);
                        printThread.start();
                    }
                }
                //HiproConf.readTime = System.currentTimeMillis();
                byte[] data = intent.getByteArrayExtra(BluetoothLeService.EXTRA_DATA);
//					System.out.println("接收BLE数据：" + BluetoothLeService.Bytes2HexString(data));
                readList.add(data);
            } else if (BluetoothLeService.ACTION_DATA_SENDFINISH.equals(action)) {
                String s = BluetoothLeService.Bytes2HexString(intent.getByteArrayExtra(BluetoothLeService.EXTRA_DATA));
                if (HiproConf.isTestBluetooth) {
                    sendToClent(DATA_SEND_BACK, 0, 0, s);
                }
//					Log.e("SEND Data :", "已发送数据: " +s + " length:"+(s.length()/2) + " time:" +System.currentTimeMillis() );

            } else if (BluetoothLeService.ACTION_GATT_DATA_READ.equals(action)) {
                if (!isConnecting) {
                    isConnecting = true;
                    setCanWrite(true);
                    writeThread = new Thread(writeRunnable);
                    writeThread.start();
                    if (printThread == null) {
                        printThread = new Thread(pritRunnable);
                        printThread.start();
                    }
                }

            }
        }
    };
    /**
     * 广播接收器，负责接收BluetoothLeService类发送的数据
     */
    private final BroadcastReceiver mGattUpdateReceiver1 = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            final String action = intent.getAction();

            if (BluetoothLeService.ACTION_GATT_CONNECTED.equals(action))//Gatt连接成功
            {
                //更新界面，连接状态
                //updateConnectionState(status);
                System.out.println("BroadcastReceiver :" + "device connected");
                //sendToClent( BLE_CONN_SUCESS,0,0,null);
                //isConnecting = true;
            } else if (BluetoothLeService.ACTION_GATT_DISCONNECTED.equals(action))//Gatt连接失败

            {
                //更新界面，连接状态
                //updateConnectionState(status);
                System.out.println("BroadcastReceiver :" + "device disconnected");
//					if(connCount <3){
//					connect(mDeviceAddress);
//					System.out.println("re Connected");
//					return;
//					}

                sendToClent(BLE_CONN_FAILE, 0, 0, null);
                isConnecting = false;
                if (writeThread != null) writeThread.interrupt();
            } else if (BluetoothLeService.ACTION_GATT_SERVICES_DISCOVERED//发现GATT服务器
                    .equals(action)) {

                //获取设备的所有蓝牙服务

                //displayGattServices1(mBluetoothLeService.getSupportedGattServices());
                displayGattServices(mBluetoothLeService.getSupportedGattServices());

                System.out.println("BroadcastReceiver :" + "device SERVICES_DISCOVERED");
            } else if (BluetoothLeService.ACTION_DATA_AVAILABLE.equals(action))//有效数据
            {
                if (!isConnecting) {
                    isConnecting = true;
                    if (writeThread == null) {
                        writeThread = new Thread(writeRunnable);
                        writeThread.start();
                    }
                    if (printThread == null) {
                        printThread = new Thread(pritRunnable);
                        printThread.start();
                    }
                }
                byte[] data = intent.getByteArrayExtra(BluetoothLeService.EXTRA_DATA);
                readList.add(data);
            } else if (BluetoothLeService.ACTION_DATA_SENDFINISH.equals(action)) {
                String s = BluetoothLeService.Bytes2HexString(intent.getByteArrayExtra(BluetoothLeService.EXTRA_DATA));
                if (HiproConf.isTestBluetooth) {
                    sendToClent(DATA_SEND_BACK, 0, 0, s);
                }
                //Log.e("SEND Data :", "已发送数据: " +s + " length:"+(s.length()/2) + " time:" +System.currentTimeMillis() );

            } else if (BluetoothLeService.ACTION_GATT_DATA_READ.equals(action)) {
                if (!isConnecting) {
                    isConnecting = true;
                    writeThread = new Thread(writeRunnable);
                    writeThread.start();
                    if (printThread == null) {
                        printThread = new Thread(pritRunnable);
                        printThread.start();
                    }
                }

            }
        }
    };

    private void sendData(int insCode, String channelName, byte[] data1) {
        Bundle b = new Bundle();
        b.putString("channel_name", channelName);
        b.putByteArray("ins_data", data1);
        b.putInt("ins_code", insCode);
        sendToClent(DEVICE_DATA_RECEIVE, b);
    }

    private void sendData1(int insCode, String channelName, String data1) {
        Bundle b = new Bundle();
        b.putString("channel_name", channelName);
        b.putString("ins_data", data1);
        b.putInt("ins_code", insCode);
        sendToClent(DEVICE_DATA_RECEIVE, b);
    }

    private void sendData(int insCode, String channelName, byte[] data, String dataString) { //?????
        Bundle b = new Bundle();
        b.putString("channel_name", channelName);
        b.putByteArray("ins_data", data);
        b.putString("ins_data_string", dataString);
        b.putInt("ins_code", insCode);
        Log.e(TAG, "发送数据");
        if (HiproConf.WifiMod != 2) {
            sendToClent(DEVICE_DATA_RECEIVE, b);
        } else {
            String cName = HiproConf.clentid + "";
            if (HiproConf.clentid < 10) cName = "0" + cName;
            if (channelName.contains("A")) cName = cName + "A";
            if (channelName.contains("B")) cName = cName + "B";
            if (channelName.contains("C")) cName = cName + "C";

            Log.d(HiproConf.tcpTag, "发送数据，通道：" + cName + ",clent id:" + HiproConf.clentid);
            ByteDataTcp temp = new ByteDataTcp();
            temp.setChannel_name(cName);
            temp.setIns_data(data);
            temp.setIns_data_string(BluetoothLeService.Bytes2HexString(data));
            temp.setIns_code(insCode);

            TcpMessage msg = new TcpMessage();
            msg.setMsgWaht(TcpProc.ByteData_Send);
            msg.setMsgInt(HiproConf.clentid);
            msg.setMsgObj(temp);

            if (tcpclent != null) {
                tcpclent.sendMsg(TcpProc.getMsgStr(msg));
            }

            if (minaClient != null) {
                Gson gson = new Gson();
                mSendTime = System.currentTimeMillis();
                biaoshi++;
                addMessage(biaoshi, false);
//                minaClient.sendMessage(HiproConf.clentid + "", MsgProc.ByteData_Send, biaoshi+"_"+gson.toJson(temp));
                sendTcpMessage(HiproConf.clentid + "", MsgProc.ByteData_Send, biaoshi + fengefu+ gson.toJson(temp));
            } else {
//                Toast.makeText(context, "没有呢还", Toast.LENGTH_SHORT).show();
            }
        }
        //sendToClent(DEVICE_DATA_RECEIVE, b);
    }

    private boolean fasong = false;
    private long biaoshi = -1;

    private ConcurrentHashMap<Long, Boolean> xiaoxi = new ConcurrentHashMap<>();
    private ReentrantLock teslisLoc = new ReentrantLock();
    private final int NUMBER_OF_CORES = Runtime.getRuntime().availableProcessors() *2;
    private final ExecutorService executorRunEvent =
            new ThreadPoolExecutor(NUMBER_OF_CORES, NUMBER_OF_CORES, KEEP_ALIVE_TIME, KEEP_ALIVE_TIME_UNIT, taskQueue
//            );
                    , new NamedThreadFactory("事件运行线程"));

    private void sendTcpMessage(final String id, final int type, final String data) {
        executorRunEvent.execute(new Runnable() {
            @Override
            public void run() {
                for (int i = 0; i < 3; i++) {
                    minaClient.sendMessage(id, type, data);
                    long sendTime = System.currentTimeMillis();
                    while (System.currentTimeMillis() - sendTime < 15000) {
                        if (getMessageSendState(Long.parseLong(data.split(fengefu)[0]))) {
                            removeMessage(Long.parseLong(data.split(fengefu)[0]));
                            executorRunEvent.shutdownNow();
                            return;
                        }

                    }
                }
                executorRunEvent.shutdownNow();
            }
        });


    }

    private void sendTcpServerMessage(final String id, final int type, final String data) {
        executorRunEvent.execute(new Runnable() {
            @Override
            public void run() {
                for (int i = 0; i < 3; i++) {
                    minaServer.sendMessage(id, type, data);
                    long sendTime = System.currentTimeMillis();
                    while (System.currentTimeMillis() - sendTime < 15000) {
                        if (getMessageSendState(Long.parseLong(data.split(fengefu)[0]))) {
                            removeMessage(Long.parseLong(data.split(fengefu)[0]));
                            executorRunEvent.shutdownNow();
                            return;
                        }

                    }
//                    Log.e("qiao","data:"+data+"--消息存储状态："+getMessageSendState(Long.parseLong(data.split(fengefu)[0])));
                }
                executorRunEvent.shutdownNow();
            }
        });

    }

    public void addMessage(Long key, Boolean states) {
        while (!teslisLoc.tryLock()) {
            postDealy(1);
        }
        xiaoxi.put(key, states);
        teslisLoc.unlock();
    }

    public void removeMessage(Long key) {
        while (!teslisLoc.tryLock()) {
            postDealy(1);
        }
        xiaoxi.remove(key);
        teslisLoc.unlock();
    }

    public Boolean getMessageSendState(Long key) {
        while (!teslisLoc.tryLock()) {
            postDealy(1);
        }
        Boolean temp = xiaoxi.get(key);
        teslisLoc.unlock();
        return temp;
    }

    /**
     * 延迟时间
     *
     * @param times
     * @return
     */
    private boolean postDealy(int times) {
        Thread.currentThread();
        try {
            Thread.sleep(times);
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    private void sendData(Bundle b) {
        sendToClent(DEVICE_DATA_RECEIVE, b);
    }


    /**
     * @param
     * @return void
     * @throws
     * @Title: displayGattServices
     * @Description: TODO(处理蓝牙服务)
     */
    private void displayGattServices(List<BluetoothGattService> gattServices) {
        Log.d("bleconn", "查找服务");
        if (gattServices == null)
            return;
        String uuid = null;
//			String unknownServiceString = "unknown_service";
//			String unknownCharaString = "unknown_characteristic";

        // 服务数据,可扩展下拉列表的第一级数据
        ArrayList<HashMap<String, String>> gattServiceData = new ArrayList<HashMap<String, String>>();

        // 特征数据（隶属于某一级服务下面的特征值集合）
        ArrayList<ArrayList<HashMap<String, String>>> gattCharacteristicData = new ArrayList<ArrayList<HashMap<String, String>>>();

        // 部分层次，所有特征值集合
        mGattCharacteristics = new ArrayList<ArrayList<BluetoothGattCharacteristic>>();

        // Loops through available GATT Services.
        for (BluetoothGattService gattService : gattServices) {

            // 获取服务列表
            HashMap<String, String> currentServiceData = new HashMap<String, String>();
            uuid = gattService.getUuid().toString();

            // 查表，根据该uuid获取对应的服务名称。SampleGattAttributes这个表需要自定义。

            gattServiceData.add(currentServiceData);

            Log.d("bleconn", "Service uuid:" + uuid);
            //System.out.println("Service uuid:" + uuid);

            ArrayList<HashMap<String, String>> gattCharacteristicGroupData = new ArrayList<HashMap<String, String>>();

            // 从当前循环所指向的服务中读取特征值列表
            List<BluetoothGattCharacteristic> gattCharacteristics = gattService
                    .getCharacteristics();

            ArrayList<BluetoothGattCharacteristic> charas = new ArrayList<BluetoothGattCharacteristic>();

            // Loops through available Characteristics.
            // 对于当前循环所指向的服务中的每一个特征值
            for (final BluetoothGattCharacteristic gattCharacteristic : gattCharacteristics) {
                charas.add(gattCharacteristic);
                HashMap<String, String> currentCharaData = new HashMap<String, String>();
                uuid = gattCharacteristic.getUuid().toString();

                //如果是需要连接的特征值
                if (gattCharacteristic.getUuid().toString().equals(HEART_RATE_MEASUREMENT)) {

                    // 接受Characteristic被写的通知,收到蓝牙模块的数据后会触发mOnDataAvailable.onCharacteristicWrite()
                    mBluetoothLeService.setCharacteristicNotification(gattCharacteristic, true);
                    mBluetoothLeService.set_isConnecting(true);
                    target_chara = gattCharacteristic;
                    reconnCount = 0;

                    Log.d("bleconn", "找到特征值");


                    byte[] b = HANDSHAKE_INS_BUF.clone();
                    b[1] = A3BLEProcessor.passAdress(HiproConf.channelList.get(0));
                    b[19] = A3BLEProcessor.chenk_byte(b, 1, 18);
                    if (clentHandler != null) {
                        // 测试读取当前Characteristic数据，会触发mOnDataAvailable.onCharacteristicRead()
                        clentHandler.postDelayed(new Runnable() {
                            @Override
                            public void run() {
                                // TODO Auto-generated method stub
                                mBluetoothLeService.readCharacteristic(gattCharacteristic);
                                //mBluetoothLeService.readCharacteristic(gattCharacteristic);
                                //isConnecting = true;
                                byte[] data = {(byte) 0xFF, (byte) 0x3c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3C,
                                        0x00};

                                mBluetoothLeService.setCanWrit(true);
                                if (checkBLEConnStateThread != null && canInterrupt) {
                                    canInterrupt = false;
                                    checkBLEConnStateThread.interrupt();
                                }
                                //if(HiproConf.isSelfCheck)
                                writeData(data);
                                //mBluetoothLeService.setWrtieState(true);
                                // mBluetoothLeService.writeCharacteristic(gattCharacteristic);
                            }
                        }, 2000);
                    }


                    break;
                }
                List<BluetoothGattDescriptor> descriptors = gattCharacteristic
                        .getDescriptors();
                for (BluetoothGattDescriptor descriptor : descriptors) {
                    System.out.println("---descriptor UUID:"
                            + descriptor.getUuid());
                    // 获取特征值的描述
                    mBluetoothLeService.getCharacteristicDescriptor(descriptor);
//						 mBluetoothLeService.setCharacteristicNotification(gattCharacteristic,
//						 true);
                }

                gattCharacteristicGroupData.add(currentCharaData);
            }
            Log.d("", "特征值查找完成");
            // 按先后顺序，分层次放入特征值集合中，只有特征值
            mGattCharacteristics.add(charas);
            // 构件第二级扩展列表（服务下面的特征值）
            gattCharacteristicData.add(gattCharacteristicGroupData);

        }
        //发现服务完成

        mBluetoothLeService.setReConnecting(false);
    }

    /**
     * @param
     * @return void
     * @throws
     * @Title: displayGattServices1
     * @Description: TODO(处理蓝牙服务 ， 遍历蓝牙服务 ， 找出所需要的特征值)
     */
    private void displayGattServices1(List<BluetoothGattService> gattServices) {
        if (gattServices == null)
            return;
        String uuid = null;
        // 部分层次，所有特征值集合
        mGattCharacteristics = new ArrayList<ArrayList<BluetoothGattCharacteristic>>();
        // Loops through available GATT Services.
        for (BluetoothGattService gattService : gattServices) {
            uuid = gattService.getUuid().toString();
            System.out.println("Service uuid:" + uuid);
            //获取当前服务特征值列表
            List<BluetoothGattCharacteristic> gattCharacteristics = gattService.getCharacteristics();
            //遍历当前服务特征值列表
            for (final BluetoothGattCharacteristic gattCharacteristic : gattCharacteristics) {
                //charas.add(gattCharacteristic);
                //HashMap<String, String> currentCharaData = new HashMap<String, String>();
                uuid = gattCharacteristic.getUuid().toString();
                //如果为要寻找的特征值
                if (gattCharacteristic.getUuid().toString().equals(HEART_RATE_MEASUREMENT)) {
                    target_chara = gattCharacteristic;
                    // 测试读取当前Characteristic数据，会触发mOnDataAvailable.onCharacteristicRead()
                    mhandler.postDelayed(new Runnable() {
                        @Override
                        public void run() {
                            // TODO Auto-generated method stub
                            mBluetoothLeService
                                    .readCharacteristic(gattCharacteristic);
                        }
                    }, 200);
                    // 接受Characteristic被写的通知,收到蓝牙模块的数据后会触发mOnDataAvailable.onCharacteristicWrite()
                    mBluetoothLeService.setCharacteristicNotification(gattCharacteristic, true);


//						startSendThread();
//						startWriteThread();
//
//						isConnecting = true;


                    // 设置数据内容
                    // 往蓝牙模块写入数据
                    mBluetoothLeService.writeCharacteristic(gattCharacteristic);
                }
            }
        }

//			if (gattServices == null)
//				return;
//			String uuid = null;
//			// 部分层次，所有特征值集合
//			mGattCharacteristics = new ArrayList<ArrayList<BluetoothGattCharacteristic>>();
//
//			// Loops through available GATT Services.
//			for (BluetoothGattService gattService : gattServices)
//			{
//				uuid = gattService.getUuid().toString();
//				System.out.println("Service uuid:" + uuid);
//				//获取当前服务特征值列表
//				List<BluetoothGattCharacteristic> gattCharacteristics = gattService.getCharacteristics();
//				//遍历当前服务特征值列表
//				for (final BluetoothGattCharacteristic gattCharacteristic : gattCharacteristics)
//				{
//					//charas.add(gattCharacteristic);
//					//HashMap<String, String> currentCharaData = new HashMap<String, String>();
//					uuid = gattCharacteristic.getUuid().toString();
//					//如果为要寻找的特征值
//					if (gattCharacteristic.getUuid().toString().equals(HEART_RATE_MEASUREMENT))
//					{
//						// 测试读取当前Characteristic数据，会触发mOnDataAvailable.onCharacteristicRead()
//						mhandler.postDelayed(new Runnable()
//						{
//							@Override
//							public void run()
//							{
//								// TODO Auto-generated method stub
//								mBluetoothLeService.readCharacteristic(gattCharacteristic);
//							}
//						}, 200);
////
//						// 接受Characteristic被写的通知,收到蓝牙模块的数据后会触发mOnDataAvailable.onCharacteristicWrite()
//						mBluetoothLeService.setCharacteristicNotification(	gattCharacteristic, true);
//						target_chara = gattCharacteristic;
//						// 设置数据内容
//						// 往蓝牙模块写入数据
//						 mBluetoothLeService.writeCharacteristic(gattCharacteristic);
//					}
//					List<BluetoothGattDescriptor> descriptors = gattCharacteristic.getDescriptors();
//					for (BluetoothGattDescriptor descriptor : descriptors)
//					{
//						System.out.println("---descriptor UUID:" + descriptor.getUuid());
//						// 获取特征值的描述
//						mBluetoothLeService.getCharacteristicDescriptor(descriptor);
//						//mBluetoothLeService.setCharacteristicNotification(gattCharacteristic, true);
//					}
//
//
//				}
//
//
//			}

    }

    /**
     * 将数据分包
     **/
    public int[] dataSeparate(int len) {
        int[] lens = new int[2];
        lens[0] = len / 20;
        lens[1] = len - 20 * lens[0];
        return lens;
    }

    private void bindReceiver() {
        //绑定广播接收
        registerReceiver(mGattUpdateReceiver, makeGattUpdateIntentFilter());
    }

    /* 意图过滤器 */
    private static IntentFilter makeGattUpdateIntentFilter() {
        final IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction(BluetoothLeService.ACTION_GATT_CONNECTED);
        intentFilter.addAction(BluetoothLeService.ACTION_GATT_DISCONNECTED);
        intentFilter.addAction(BluetoothLeService.ACTION_GATT_SERVICES_DISCOVERED);
        intentFilter.addAction(BluetoothLeService.ACTION_DATA_AVAILABLE);
        intentFilter.addAction(BluetoothLeService.ACTION_DATA_SENDFINISH);
        intentFilter.addAction(BluetoothLeService.ACTION_GATT_DATA_READ);
        return intentFilter;
    }

    private void ini_Serial() {
        Log.d("seria", "开始初始化串口");
        myport = new MySeria(HiproConf.seriaNo, HiproConf.baudrate, 0, readList);//串口
        myprinter = new MySeria(HiproConf.seriaPrintNo, HiproConf.baudratePrint, 0, printerreadList);//打印机？
        mylis = new MySeria(HiproConf.seriaLisNo, HiproConf.baudrateLis, 0, lisReadList);
        HiproConf.printAllData = true;
        Log.d("seria", "初始化串口完成");
        myport.open();
    }

    private void ini_BLuettoth() {
        mybluettoth = new BluettothClassic(context, clentHandler, readList, mBluetoothAdapter);
    }

    private void ini_BLE() {
        Log.e(TAG, "ini BLE");
        //mBluetoothLeService = new BluetoothLeService(context ,clentHandler);
        mBluetoothLeService = new BluetoothLeService(context, clentHandler, readList);
        mBluetoothLeService.initialize();
    }

    private void connect(String mac) {
        if (!isClosing) {
            Log.d("bleconn", "连接设备：" + mac + ",bluetoothver:" + HiproConf.bluetoothVer);

            if (System.currentTimeMillis() - reconnectionTime > RECONNTIME) {
                Log.d("bleconn", "连接设备：" + mac + ",bluetoothver:" + HiproConf.bluetoothVer);
                if (HiproConf.bluetoothVer == 4) {
//                if (4 == 4) {
                    if (mBluetoothLeService == null) {
                        ini_BLE();
                    }

                    LogUtil.d("threadmyser", Thread.currentThread().getId() + "");
                    mBluetoothLeService.connect(mac);
                } else if (HiproConf.bluetoothVer == 2) {

                    if (mybluettoth != null) {
                        isConnecting = mybluettoth.connDev(mac);
                    } else {
                        LogUtil.d("threadmyser", Thread.currentThread().getId() + "");
                        Toast.makeText(HiproApplication.mContext, "蓝牙2.0初始化失败，请重试！", Toast.LENGTH_SHORT).show();
                    }

                    if (writeThread == null) {
                        setCanWrite(true);
                        writeThread = new Thread(writeRunnable);
                        writeThread.start();
                    }
                    if (printThread == null) {
                        printThread = new Thread(pritRunnable);
                        printThread.start();
                    }

                } else if (HiproConf.bluetoothVer == 0) {

                    if(myport==null){
                        return;
                    }
                    isConnecting = myport.open();
                    Log.d("", "connect 打开串口");
                    if (writeThread == null) {
                        setCanWrite(true);
                        writeThread = new Thread(writeRunnable);
                        writeThread.start();
                        Log.d("", "connect 发送线程运行");
                    }
                    if (printThread == null) {
                        printThread = new Thread(pritRunnable);
                        printThread.start();
                    }
                    isprintconn = myprinter.open();

                    if (lisThread == null) {
                        lisThread = new Thread(lisRunnable);
                        lisThread.start();
                    }
                    islisconn = mylis.open();
                }
                reconnectionTime = System.currentTimeMillis();
            } else {
                final String tempmac = mac;
                if (clentHandler != null) {
                    clentHandler.postDelayed(new Runnable() {

                        @Override
                        public void run() {
                            // TODO Auto-generated method stub
                            connect(tempmac);
                        }
                    }, RECONNTIME);
                }

            }
        }

    }


    //解析完毕的数据、、、、、sendxia
    public void write(final byte[] data) {
        if (HiproConf.bluetoothVer == 4) {
            if (target_chara == null) return;
            target_chara.setValue(data);
            //调用蓝牙服务的写特征值方法实现发送数据
            try {
                if (mBluetoothLeService != null)
                    mBluetoothLeService.writeCharacteristic(target_chara);
                writelasttime = System.currentTimeMillis();
                System.out.println("BLE write: " + BluetoothLeService.Bytes2HexString(data) + " timer:" + System.currentTimeMillis());
            } catch (Exception ex) {
                Log.d(TAG, "WriteData Error");
                ex.printStackTrace();
            }
        } else if (HiproConf.bluetoothVer == 2) {
            HiproConf.MyLog("E", "BV2", "bluetooth write data1 " + "blee2.0");
            mybluettoth.writeData(data);
        } else if (HiproConf.bluetoothVer == 0) {      /////////////////////////////////// 向下位机发送数据  sendXia
            HiproConf.MyLog("E", "BV2", "seria write data0 ");
            myport.WriteData(data);
        }

    }

    private byte[] hexStringToByte(String inputStr) {
        byte[] result = new byte[inputStr.length() / 2];
        for (int i = 0; i < inputStr.length() / 2; ++i)
            result[i] = (byte) (Integer.parseInt(inputStr.substring(i * 2, i * 2 + 2), 16) & 0xff);
        return result;
    }

    StringBuilder mBuilder = new StringBuilder();


    //向蓝牙发送数据
    private void writeToBle1(final byte[] data) {

        byte[] buff;
        if (HiproConf.isSend20Bytes) {
            if (data[data.length - 1] == ((byte) 0x00)) {
                buff = new byte[data.length - 1];
                System.arraycopy(data, 0, buff, 0, data.length - 1);
            } else {
                buff = data;
            }
        } else {
            buff = data;
        }
        int len = buff.length;
        int[] lens = dataSeparate(len);
        for (int i = 0; i < lens[0]; i++) {
            byte[] send = new byte[20];
            System.arraycopy(buff, i * 20, send, 0, 20);
            //writeList.add(send);
            write(data);
        }
        if (lens[1] != 0) {
            byte[] send = new byte[lens[1]];
            System.arraycopy(buff, 20 * lens[0], send, 0, lens[1]);
            //writeList.add(send);
            write(data);
        }

    }


    //将指令加入发送缓存，马上发送
    public synchronized void writeData(final byte[] data, int type) {
        synchronized (writeLock) {
            byte[] buff;
            if (HiproConf.isSend20Bytes) {
                if (data[data.length - 1] == ((byte) 0x00)) {
                    buff = new byte[data.length - 1];
                    System.arraycopy(data, 0, buff, 0, data.length - 1);
                } else {
                    buff = data;
                }
            } else {
                buff = data;
            }
            //System.out.println("发送数据 : " +BluetoothLeService.Bytes2HexString(data) + " length:");
            int len = buff.length;
            int[] lens = dataSeparate(len);
            //System.out.println("发送数据 : Len[0]:"+lens[0] +"  lens[1]:"+lens[1]);
            for (int i = 0; i < lens[0]; i++) {
                byte[] send = new byte[20];
                System.arraycopy(buff, i * 20, send, 0, 20);
                //System.out.println("发送数据1  ：" + BluetoothLeService.Bytes2HexString(send) );
                writeList.add(send);
            }
            if (lens[1] != 0) {
                //System.out.println("writeData tims: last");
                byte[] send = new byte[lens[1]];
                System.arraycopy(buff, 20 * lens[0], send, 0, lens[1]);
                //System.out.println("发送数据 2 ：" + BluetoothLeService.Bytes2HexString(send) );
                writeList.add(send);
            }
        }
    }

    //如果当前处于可发送状态，则马上发送指令 ，
    //如处于不可发送状态，则将指令加入发送缓存队列，当进入可发送状态时再次发送
    public void writeData(final byte[] data) {
        synchronized (writeLock) {
//			if(!HiproConf.sendDataBacks) {
//				writeData(data,0);
//			}else{
//				writeList.add(data);
//			}
            HiproConf.MyLog("E", "BV2", "writelist add ");

            ///////////////////////addthis
            writeList.add(data);
        }
        //立即发送
//	if(canWrite){
//		writeData(data,0);
//	}else{//加入队列
//		writeListHome.add(data);
//	}


//			byte[] buff ;
//				if(HiproConf.isSend20Bytes){
//					if(data[data.length-1]==((byte)0x00)){
//					buff = new byte[data.length-1];
//					System.arraycopy(data, 0, buff, 0, data.length-1);
//					}else{
//						buff=data;
//					}
//				}else
//				{
//					buff=data;
//				}
//			//System.out.println("发送数据 : " +BluetoothLeService.Bytes2HexString(data) + " length:");
//			int len = buff.length;
//			int[] lens = dataSeparate(len);
//			//System.out.println("发送数据 : Len[0]:"+lens[0] +"  lens[1]:"+lens[1]);
//			for(int i =0;i<lens[0];i++)
//			{
//				byte [] send = new byte[20];
//				System.arraycopy(buff, i*20, send, 0, 20);
//				//System.out.println("发送数据1  ：" + BluetoothLeService.Bytes2HexString(send) );
//				writeList.add(send);
//			}
//			if(lens[1]!=0)
//			{
//				//System.out.println("writeData tims: last");
//				byte [] send = new byte[lens[1]];
//				System.arraycopy(buff, 20*lens[0], send, 0, lens[1]);
//				//System.out.println("发送数据 2 ：" + BluetoothLeService.Bytes2HexString(send) );
//				writeList.add(send);
//			}

    }

    private NetworkReceiver netWorkLisenter = new NetworkReceiver();

    private void registerNetWorkLisner() {
        IntentFilter filter = new IntentFilter();
        filter.addAction(WifiManager.WIFI_STATE_CHANGED_ACTION);
        filter.addAction(WifiManager.NETWORK_STATE_CHANGED_ACTION);
        filter.addAction(ConnectivityManager.CONNECTIVITY_ACTION);
        registerReceiver(netWorkLisenter, filter);
    }

    private void unregisterNetWorkLisenter() {
        try {
            unregisterReceiver(netWorkLisenter);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }


    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        // TODO Auto-generated method stub
        Log.e("MyService", "onStartCommand");
        return super.onStartCommand(intent, flags, startId);
    }

    private static int startIndex = 0;

    @Override
    public void onCreate() {
        // TODO Auto-generated method stub
        super.onCreate();
        Log.e("MyService", "onCreate" + (minaServer==null));
        startIndex++;
        Log.d(HiproConf.tcpTag, "Myserver oncreate:" + startIndex);
        context = this;
        PendingIntent p_intent = PendingIntent.getActivity(this, 0, new Intent(this, WorkActivity.class), 0);
        Notification.Builder builder = new Notification.Builder(this);
        builder.setSmallIcon(R.drawable.logo)
                .setContentTitle("Hipro").setContentText("Working")
                .setContentIntent(p_intent);
        Notification notification = builder.getNotification();
        startForeground(0x1988, notification);   // notification ID: 0x1988, you can name it as y
        startUploade();
        uploadDatabase();
        uploadControlDatabase();
        System.out.println("Myservic Start");
        mBluetoothAdapter = ((BluetoothManager) context.getSystemService(Context.BLUETOOTH_SERVICE)).getAdapter();
        bindReceiver();
        try {
            getLocation();
        } catch (Exception ex) {
            ex.printStackTrace();
        }


        LogUtil.d("bluetoothVerzz", HiproConf.bluetoothVer + "");
        if (HiproConf.bluetoothVer == paidTagUtil.BLE_TAG) {//蓝牙4.0
            ini_BLE();
        } else if (HiproConf.bluetoothVer == 2) {//蓝牙2.0
            ini_BLuettoth();
        } else if (paidTagUtil.getPaidTags() == paidTagUtil.SER_TAG) {//串口
            ini_Serial();
        }

        registerNetWorkLisner();
        ini_ProjectFile();
        Log.e(TAG, "创建WIFI链接");
        xiaoxi=new ConcurrentHashMap<>();
        ini_WifiMod();


    }

    //上传数据库未上传的回传数据
    private void uploadDatabase() {
        ContentResolver cr = context.getContentResolver();

        //测试完成但是没有上传网络
        String untestWhere = Samples.TEST_STATUS + " =? " + " and " + Samples.IS_UPLOADE + " !=? ";
        //0未上传，1已上传，-1新服务器上传失败 -2 旧服务器上传失败！
        Cursor c = cr.query(Samples.CONTENT_URI, null, untestWhere, new String[]{
                "done", "1",}, null);

        if (c == null) {
            return;
        }
        Log.e("wang", "数据库未上传的数据数：" + c.getCount());
        if (c.getCount() <= 0) {
            c.close();
            return;
        }
        while (c.moveToNext()) {
            int idx = c.getColumnIndex(Samples._ID);
            int id = c.getInt(idx);
//            Log.e("wang", "-----------id-----" + id);

            if (!uploadeList.contains(id)) {
                uploadeList.add(id);
            }
        }

        Log.e("wang", "----------------" + uploadeList.size());
        c.close();


    }

    //上传数据库未上传的回传数据
    private void uploadControlDatabase() {
        ContentResolver cr = context.getContentResolver();
        //测试完成但是没有上传网络
        String untestWhereControl = HiproData.ControlResult.TEST_STATUS + " =? " + " and " + HiproData.ControlResult.IS_UPLOADE + " !=? ";
        //0未上传，1已上传，-1新服务器上传失败 -2 旧服务器上传失败！
        Cursor cControl = cr.query(HiproData.ControlResult.CONTENT_URI, null, untestWhereControl, new String[]{
                "done", "1",}, null);
        if (cControl == null) {
            return;
        }
        if (cControl.getCount() <= 0) {
            cControl.close();
            return;
        }
        while (cControl.moveToNext()) {
            int idx = cControl.getColumnIndex(Samples._ID);
            int id = cControl.getInt(idx);
            Log.e("wang", "-----------质控id-----" + id);
            ControlTestedInfo mControlTestedInfo = new ControlTestedInfo();
            mControlTestedInfo.sampleId = id + "";
            if (!ControlTestedInfolist.contains(mControlTestedInfo)) {
                ControlTestedInfolist.add(mControlTestedInfo);
            }
        }

        Log.e("wang", "----------------" + ControlTestedInfolist.size());
        cControl.close();
    }

    @Override
    public IBinder onBind(Intent intent) {
        // TODO Auto-generated method stub
        Log.e("MyService", "onBind");
        return serviceMessenger.getBinder();
    }


    @Override
    public void onDestroy() {
        // TODO Auto-generated method stub
        Log.e("qiao", "myservice exit");
        if (wifiReceiver != null) {
            unregisterReceiver(wifiReceiver);
        }

        unregisterReceiver(mGattUpdateReceiver);


        if (gpslocation != null)
            gpslocation.stopLocation();

        isClosing = true;

        if (target_chara != null) {
            target_chara = null;
        }
        if (mBluetoothLeService != null) {
            mBluetoothLeService.close();
        }
        if (readThread != null) {
            isReading = false;
            readThread.interrupt();
            readRunnable = null;
        }

        if (bMod != null) {
            bMod.StopRunning();
            bMod = null;
        }
        try {
            if (mybluettoth != null) {
                mybluettoth.disConnect();
            }
            uploadThread1.interrupt();
            uploadThread1 = null;
        } catch (Exception ex) {


        }

        try {
            unregisterNetWorkLisenter();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        try {
            if (tcpserver != null) {
                tcpserver.closeServer();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        try {
            if (tcpclent != null) {
                tcpclent.disConnect();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        Log.d("server", "myservice exit");
        if (HiproConf.bluetoothVer == 0) {
            try {
                if (myport != null) {
                    myport.closeSeria();
                }
                if (myprinter != null) {
                    myprinter.closeSeria();
                }
                if (mylis != null) {
                    mylis.closeSeria();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }


        if (clentHandler != null) {
            clentHandler.removeCallbacksAndMessages(null);
            clentHandler = null;
        }

        if (HiproConf.WifiMod == 1) {
            if (minaServer != null) {
                for (String key : Constant.sessionMap.keySet()) {
                    minaServer.sendMessage(key, MsgProc.DISCONNECT, "");
                    Log.e("disC", key);
                    Log.d("server", "myservice exit");
                }
                minaServer.disConnect();
                minaServer = null;

            }

        }

        if (mHandler_xintiao != null) {
            mHandler_xintiao.removeCallbacks(mHeartbeatRunnable);
        }
//        android.os.Process.killProcess(android.os.Process.myPid());
        super.onDestroy();
    }

    @Override
    protected void onHandleIntent(Intent intent) {
        // TODO Auto-generated method stub
        Log.e("MyService", "onHandleIntent");
    }

    /*****二维码处理*****/
    class QrData {

        public String itemName;            //项目名称
        public String platform;            //
        public int decimalLen;            //小数位数
        public String lotNumber;        //试剂批号
        public String expirationDate;    //有效 期
        public String resultUnit;        //结果单位
        public String firstTime;        //首次测量时间
        public String lastTime;            //末次测量时 间
        public double refUpperLimit;   //正常范围上限
        public double refLowerLimit;   //正常范围下线
        public String type;//0:血清，1：全血，2：其他
        public String testMode;            //测试模式
        public double linearUpperLimit;//测试线性范围上限，
        public double linearLowerLimit;//测试线性范围下限

        public double constRation;
        public double firstRation;
        public double secondRation;
        public double thirdRation;
        public double forthRation;
        public double fifthRation;
        public double sixthRation;

        //是否下发
        public boolean isSendRation = false;
        //下发字节1
        public byte[] ration1;
        //下发字节2
        public byte[] ration2;
        //下发次数
        public int rationCont = 0;

        public void convertQr1(A3QrInstruction qrInsOne) {


            //Log.d(TAG, "二维码解析1");

            itemName = qrInsOne.getItemName().trim();
            //itemName = "hs-CRP";
            platform = qrInsOne.getTestPlatform().trim();
            decimalLen = Integer.valueOf(qrInsOne.getDecimalLen().trim());

            lotNumber = qrInsOne.getLotNumber().trim();
            //lotNumber ="CA150811";
            expirationDate = qrInsOne.getValidDate().trim();
            resultUnit = qrInsOne.getResultUnit().trim();
            firstTime = qrInsOne.getFirstTestTime().trim();
            lastTime = qrInsOne.getLastTestTime().trim();
            refUpperLimit = convertToDouble(qrInsOne.getReferenceUpperLimit());
            refLowerLimit = convertToDouble(qrInsOne.getReferenceLowerLimit());
            type = qrInsOne.getType().trim();
        }

        public void convertQr2(A3QrInstruction qrInsTwo) {
            //Log.d(TAG, "二维码解析2");
            testMode = qrInsTwo.getTestMode().trim();
            linearUpperLimit = convertToDouble(qrInsTwo.getLinearUpperLimit());
            linearLowerLimit = convertToDouble(qrInsTwo.getLinearLowerLimit());
			/*constRation = convertToRation(qrInsTwo.getConstRatio().trim());
			firstRation = convertToRation(qrInsTwo.getFirstRatio().trim());
			secondRation = convertToRation(qrInsTwo.getSecondRatio().trim());
			thirdRation = convertToRation(qrInsTwo.getThirdRatio().trim());
			forthRation = convertToRation(qrInsTwo.getForthRatio().trim());
			fifthRation = convertToRation(qrInsTwo.getFifthRatio().trim());
			sixthRation = convertToRation(qrInsTwo.getSixthRatio().trim());*/

            constRation = qrInsTwo.getConstRatio();
            firstRation = qrInsTwo.getFirstRatio();
            secondRation = qrInsTwo.getSecondRatio();
            thirdRation = qrInsTwo.getThirdRatio();
            forthRation = qrInsTwo.getForthRatio();
            fifthRation = qrInsTwo.getFifthRatio();
            sixthRation = qrInsTwo.getSixthRatio();

//			Log.d(TAG, "Qr ratios: " + constRation +", " + firstRation
//					+ ", " + secondRation + ", " + thirdRation + ", "
//					+ forthRation + ", " + fifthRation + ", " + sixthRation);
        }

        private double convertToRation(String strVal) {
            StringBuffer buf = new StringBuffer();
            if (strVal.charAt(0) == 0x2d) {//符号位
                buf.append("-");
            }
            buf.append(strVal.charAt(1));//整数
            buf.append(".");
            buf.append(strVal.charAt(2));//小数
            buf.append(strVal.charAt(3));//小数
            buf.append("e");
            if (strVal.charAt(4) == 0x2d) {//符号位
                buf.append("-");
            }
            buf.append(strVal.charAt(5));//指数
            buf.append(strVal.charAt(6));//指数
            return Double.parseDouble(buf.toString());
        }

        private double convertToDouble(String str) {
            if (str.length() != 6)
                return 0.0;
            StringBuffer buf = new StringBuffer(str.substring(0, 4));
            buf.append(".");
            buf.append(str.substring(4));
            return Double.valueOf(buf.toString());
        }


    }


    public boolean[] qrIsReceive = {false, false, false, false, false, false, false, false, false};
    public byte[] qrdata = new byte[126];
    public QrData qrData = new QrData();

    private void doQrcode(byte[] recData) {
        A3BLEProcessor insParser = new A3BLEProcessor();

        int position = recData[16];
        qrIsReceive[position] = true;
        System.arraycopy(recData, 2, qrdata, position * 14, 14);
        boolean flag = true;
        //是否接收完成
        int i = 0;
        for (i = 0; i < 9; i++) {
            flag = flag && qrIsReceive[i];
        }
        //接收完成，处理数据
        if (flag) {
            A3QrInstruction a3qr = (A3QrInstruction) insParser.parseQRCode(qrdata);
            try {
                a3qr.parseTotal();
                qrData.convertQr1(a3qr);
                qrData.convertQr2(a3qr);
                //Log.e(TAG,"二维码处理完成");
            } catch (Exception ex) {
                ex.printStackTrace();
                System.out.println("Myservice , 二维码解析错误：" + BluetoothLeService.Bytes2HexString(qrdata));
                return;
            }


        }

    }


    private int downLoadParms() {
        String dataURL = HiproConf.DOWNLOAD_DATA_URL;
        List<BasicNameValuePair> queryParams = new LinkedList<BasicNameValuePair>();
        String sampleLastDate = "";
        String controlLastDate = "";
        SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(context);


        if (!HiproConf.needupdate) {
            String temp = sp.getString(HiproConf.UPDATE_ONLINE_TIME, "2015-01-01");
            Log.d("", "needupdate,controlLastDate :" + temp);
            if (temp.length() == 0) {
                controlLastDate = "2015-01-01".substring(0, 10).replaceAll("-", "").substring(2);
            } else {
                //	controlLastDate= sp.getString(HiproConf.UPDATE_ONLINE_TIME, "2015-01-01");
                controlLastDate = temp.substring(0, 10).replaceAll("-", "").substring(2);
            }

            if (controlLastDate.length() == 0)
                controlLastDate = "2015-01-01".substring(0, 10).replaceAll("-", "").substring(2);
            sampleLastDate = controlLastDate;
        } else {
            controlLastDate = "2015-01-01".substring(0, 10).replaceAll("-", "").substring(2);
            sampleLastDate = "2015-01-01".substring(0, 10).replaceAll("-", "").substring(2);
            HiproConf.needupdate = false;
        }

//		controlLastDate ="2015-01-01".substring(0,10).replaceAll("-", "").substring(2);
//		sampleLastDate = "2015-01-01".substring(0,10).replaceAll("-", "").substring(2);
//		HiproConf.InsNo="0";
        // HiproConf.InsNo="16060306006";

        queryParams.add(new BasicNameValuePair("sample", sampleLastDate));
        queryParams.add(new BasicNameValuePair("control", controlLastDate));
        queryParams.add(new BasicNameValuePair("mNo", HiproConf.getInsNo()));
        queryParams.add(new BasicNameValuePair("simno", HiproConf.getSimCode()));
        //对参数编码
        String queryString = URLEncodedUtils.format(queryParams, "UTF-8");
        //将URL与参数拼接
        HttpGet getMethod = new HttpGet(dataURL + "?" + queryString);

//		HttpGet getMethod = new HttpGet( HiproConf.DOWNLOAD_DATA_URL);
        Log.i(TAG, "sampleLastDate:" + sampleLastDate + " ,controlLastDate:" + controlLastDate);
        Log.i(TAG, "Download URLA3: " + getMethod.getURI().toString());
        HttpClient httpClient = new DefaultHttpClient();


        httpClient.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT, 10000);
        httpClient.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT, 10000);

        try {
            Log.d("", "访问开始");
            //发起GET请求
            HttpResponse response = httpClient.execute(getMethod);
            Log.d("", "访问结束");
            //获取响应码
            Log.i(TAG, "Download resCode: " + response.getStatusLine().getStatusCode());
            //获取服务器响应内容 [网页访问到的内容]
            String data = EntityUtils.toString(response.getEntity(), "utf-8");

            Log.i(TAG, "Download Data: " + data);
            //
            //data = readAssetData();
            Log.d(TAG, "anyTese receive data:" + data);
            //解析JSON
            //RatioData ratioData = JSON.parseObject(data, RatioData.class);
            //ratioData.parse();
            //ratioData.save(getContentResolver());
            //ratioData.save(getContentResolver(),context);

            return 1;
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }


        return 0;

    }

    /*********网络设置参数**********/

    private static int isSetingFinish = 0;
    private static String setResut = "0";
    private static ReentrantLock setLoc = new ReentrantLock();

    public static void setIsSetingFinish(int isfinish, String r) {
        setLoc.lock();
        isSetingFinish = isfinish;
        setResut = r;
        setLoc.unlock();
    }

    public static int getisSetFinish() {
        setLoc.lock();
        int temp = isSetingFinish;
        setLoc.unlock();
        return temp;
    }

    public static String getSetResult() {
        setLoc.lock();
        String t = setResut;
        setLoc.unlock();
        return t;
    }

    private Thread GetResThread = null;
    private volatile boolean isGetParInfo = false;

    private void startUpLoaPar() {
        int networkType = Constants.getNetWorkStatus(context);
        if (networkType != Constants.NETWORK_WIFI) return;
        if (GetResThread != null) {
            isGetParInfo = false;
            GetResThread.interrupt();
            GetResThread = null;
        }
        GetResThread = new Thread(new Runnable() {

            @Override
            public void run() {
                // TODO Auto-generated method stub
                isGetParInfo = true;
                while (isGetParInfo) {
//					try {
//						upLoaPar();
//					}catch(Exception ex) {
//						ex.printStackTrace();
//					}
//

//					try {
//						downLoadParPerTime();
//					}catch(Exception ex) {
//						ex.printStackTrace();
//					}


                    Thread.currentThread();
                    try {
                        Thread.sleep(10 * 1000);
                    } catch (InterruptedException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }

                }
            }
        });
        Log.e("getpar", "getpar,开始更新模块信息");
        GetResThread.start();
    }

    private void upLoaPar() {
        String needUpload = HiproConf.getIsupLoadPAR();
        //存在更新
        if (!"0".equals(needUpload)) {
            //id:3;type:0;value:0,1,0,0,0,0,0;c:01A
            String[] temps = needUpload.split(";");
            String id = null;
            String types = null;
            String values = null;
            String c = null;
            for (int i = 0; i < temps.length; i++) {
                if (temps[i].contains("id")) {
                    id = temps[i].replace("id:", "");
                } else if (temps[i].contains("type")) {
                    types = temps[i].replace("type:", "");
                } else if (temps[i].contains("value")) {
                    values = temps[i].replace("value:", "");
                } else if (temps[i].contains("c:")) {
                    c = temps[i].replace("c:", "");
                }
            }
//			Log.e("getpar", "getpar,id:"+id+",type:"+types+",values:"+values+",c:"+c);
            if (id == null || types == null || values == null || c == null) {
                return;
            }

            byte cbyte = A3BLEProcessor.passAdress(c);
            int cInt = cbyte & 0xFF;
            if (!(cInt > 0 && cInt <= 48)) return;

            //执行动作
            boolean actionFinish = false;

            //散射系数设置
            if ("0".equals(types)) {
//				Log.e("getpar", "getpar,设置散射系数");
                //散射系数设置
                String[] myValue = values.split(",");
                if (myValue.length == 3) {
                    double[] setValue = new double[3];
                    try {
                        for (int i = 0; i < 3; i++) {
                            setValue[i] = Double.parseDouble(myValue[i]);
                        }
                        actionFinish = setSanShe(cbyte, setValue);
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                }
            } else if ("1".equals(types)) {
                //吸光系数设置
//				Log.e("getpar", "getpar,设置吸光系数");
                String[] myValue = values.split(",");
                if (myValue.length == 6) {
                    float[] setValue = new float[6];
                    try {
                        for (int i = 0; i < 6; i++) {
                            setValue[i] = Float.parseFloat(myValue[i]);
                        }
                        actionFinish = sendxiguang(cbyte, setValue);
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                }

            } else if ("2".equals(types)) {
                //读取系数
//				Log.e("getpar", "getpar,读取参数");
                try {
                    actionFinish = readPar(cbyte);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }

            Log.e("getpar", "result,id:" + id + ",result:" + actionFinish + ",data:" + getSetResult());
            //根据结果反馈服务器
            if (actionFinish) {
                HiproConf.setupLoadParBack(id, 0 + "", getSetResult());
            } else {
                HiproConf.setupLoadParBack(id, 1 + "", getSetResult());
            }
        }

    }

    private boolean setSanShe(byte channel, double[] values) {

        for (int i = 0; i < 3; i++) {
            Log.e("getpar", "setSanShe,i:" + i);///////////
            boolean bx = sendSansen(i, channel, values[i]);
            if (!bx) return false;
            Thread.currentThread();
            try {
                Thread.sleep(300);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return true;
    }

    private boolean sendSansen(int type, byte channel, double value) {

        byte[] temp = null;
        switch (type) {
            case 0:
                temp = A3BLEProcessor.buildSanSHe_A0(value);
                break;
            case 1:
                temp = A3BLEProcessor.buildSanSHe_A1(value);
                break;
            case 2:
                temp = A3BLEProcessor.buildSanSHe_A2(value);
                break;
        }
        Log.e("getpar", "setSanShe,value" + value + ",data:" + BluetoothLeService.Bytes2HexString(temp));
        if (temp == null) return false;
        temp[1] = channel;
        temp[temp.length - 2] = A3BLEProcessor.chenk_byte(temp, 1, temp.length - 3);
        MyService.setIsSetingFinish(0, "0");
        writeToBle1(temp);

        long temptime = System.currentTimeMillis();
        while ((System.currentTimeMillis() - temptime) < 3000) {
            if (MyService.getisSetFinish() == 1) {
                return true;
            }
        }
        return false;
    }

    private boolean sendxiguang(byte channel, float[] value) {
        byte[] temp = null;
        boolean sucess = false;
        //A0-A3
        temp = A3BLEProcessor.buildXiGuang_A0_A3(value);
        if (temp == null) return false;
        temp[1] = channel;
        temp[temp.length - 2] = A3BLEProcessor.chenk_byte(temp, 1, temp.length - 3);
        MyService.setIsSetingFinish(0, "0");
        writeToBle1(temp);

        long temptime = System.currentTimeMillis();
        while ((System.currentTimeMillis() - temptime) < 3000) {
            if (MyService.getisSetFinish() == 1) {
                sucess = true;
                break;
            }
        }
        Log.e("getpar", "getpar,A0_A3:" + sucess);
        if (!sucess)
            return false;
        //A4-A5
        temp = A3BLEProcessor.buildXiGuang_A4_A5(value);
        if (temp == null) return false;
        temp[1] = channel;
        temp[temp.length - 2] = A3BLEProcessor.chenk_byte(temp, 1, temp.length - 3);
        MyService.setIsSetingFinish(0, "0");
        writeToBle1(temp);

        temptime = System.currentTimeMillis();
        while ((System.currentTimeMillis() - temptime) < 3000) {
            if (MyService.getisSetFinish() == 1) {
                Log.e("getpar", "getpar,A4_A5:" + true);
                return true;
            }

        }
        Log.e("getpar", "getpar,A4_A5:" + false);
        return false;
    }

    private boolean readPar(byte channel) {
        byte[] temp = A3BLEProcessor.buildReadPar();
        if (temp == null) return false;
        temp[1] = channel;
        temp[temp.length - 2] = A3BLEProcessor.chenk_byte(temp, 1, temp.length - 3);
        MyService.setIsSetingFinish(0, "0");
        writeToBle1(temp);

        long temptime = System.currentTimeMillis();
        while ((System.currentTimeMillis() - temptime) < 3000) {

            if (MyService.getisSetFinish() == 1) {
                return true;
            }

            Thread.currentThread();
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return false;
    }

    private Thread UploadPerTime = null;

    private void startUpLoaPar_parTime() {
        if (UploadPerTime != null) {
            isGetParInfo = false;
            UploadPerTime.interrupt();
            UploadPerTime = null;
        }
        UploadPerTime = new Thread(new Runnable() {

            @Override
            public void run() {
                // TODO Auto-generated method stub
                isGetParInfo = true;
                while (isGetParInfo) {
//					try {
//						upLoaPar();
//					}catch(Exception ex) {
//						ex.printStackTrace();
//					}


                    try {
                        downLoadParPerTime();
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }


                    Thread.currentThread();
                    try {
                        Thread.sleep(10 * 1000);
                    } catch (InterruptedException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }
            }
        });
        Log.e("getpar", "getpar,开始更新曲线");
        UploadPerTime.start();
    }

    private void downLoadParPerTime() {
        String dataURL = HiproConf.GET_PAR_PER_TIME;
        List<BasicNameValuePair> queryParams = new LinkedList<BasicNameValuePair>();
        String sampleLastDate = "";
        String controlLastDate = "";

        SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(context);
        String temp = sp.getString(HiproConf.UPDATE_ONLINE_TIME, "2015-01-01 00:11:00");

        sampleLastDate = temp;
        controlLastDate = temp;
        queryParams.add(new BasicNameValuePair("sample", sampleLastDate));
        queryParams.add(new BasicNameValuePair("control", controlLastDate));
        queryParams.add(new BasicNameValuePair("mNo", HiproConf.getInsNo()));
        queryParams.add(new BasicNameValuePair("simno", HiproConf.getSimCode()));
        //对参数编码
        String queryString = URLEncodedUtils.format(queryParams, "UTF-8");
        //将URL与参数拼接
        HttpGet getMethod = new HttpGet(dataURL + "?" + queryString);

//		HttpGet getMethod = new HttpGet( HiproConf.DOWNLOAD_DATA_URL);
//		Log.i("getpar", "Par_TIME sampleLastDate:"+sampleLastDate +" ,controlLastDate:"+controlLastDate);
//		Log.i("getpar", "Par_TIME Download URLA3: " + getMethod.getURI().toString());
        HttpClient httpClient = new DefaultHttpClient();

        try {
            //发起GET请求
            HttpResponse response = httpClient.execute(getMethod);

            //获取响应码
            Log.i("getpar", "Download resCode: " + response.getStatusLine().getStatusCode());
            //获取服务器响应内容 [网页访问到的内容]
            String data = EntityUtils.toString(response.getEntity(), "utf-8");

//			Log.i("getpar", "Download Data: " + data);
//			//
//			//data = readAssetData();
//			Log.d("getpar","anyTese receive data:"+data);
            //解析JSON
            RatioData ratioData = JSON.parseObject(data, RatioData.class);
            ratioData.parse();
            //ratioData.save(getContentResolver());
            ratioData.save(getContentResolver(), context);

            return;
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return;
    }

    private void ini_ProjectFile() {
        String fileName = FileReadWrite.getProjectFileName(context);
        String fileName1 = FileReadWrite.getProjectFileTXTName(context);
        File f = new File(fileName);
        if (!f.exists()) {
            String xml = "";
            AssetManager as = context.getAssets();
            InputStream fin;
            try {
                fin = as.open("projectinfo.xml");
                HiproConf.projectfile = new XMLHelper(fileName, fileName1, this);
                HiproConf.projectfile.openXML(fin);
                HiproConf.projectfile.SaveNewFile(fileName);
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }

        HiproConf.projectfile = new XMLHelper(fileName, fileName1, context);
        HiproConf.projectfile.openXML();
        HiproConf.projectfile.LoadProjectInfo();
    }

    /**********WIFI连接模式定义*****************/
    private WifiAdmin wifiAdmin;
    private MyTcpServer tcpserver;
    private MyTcpClent tcpclent;

    private boolean connectserverTag = true;
    //接收message，做处理
    private Handler mHandler = new Handler() {
        public void handleMessage(Message msg) {
            Log.d("handler", "收到消息：" + msg.what);
            String msgstr;
            switch (msg.what) {

                case 2:
                    TcpMessage msg1 = new TcpMessage();
                    msg1.setMsgWaht(TcpProc.Handle_bac);
                    msg1.setMsgInt(HiproConf.clentid);
                    tcpclent.sendMsg(TcpProc.getMsgStr(msg1));
                    break;
                case WIFI_STATE_APCONN:  //WIFIAP连接成功


                    LogUtil.d(HiproConf.tcpTag, "WIFI_STATE_APCONN!!");


                    if (connectserverTag) {
                        connectserver();
                        connectserverTag = false;
                    }


                    break;
                case WIFI_RECONNECT:
                    Log.e(TAG, "重新链接");
                    ini_WifiMod();
                    break;
                case WIFI_REDIAN:
                    startWIFIAP();
                    break;
//                case WIFI_ACTIVE_BREAK_OFF:
//                    Log.e(TAG, "主动断开wifi链接");
//                    if (minaClient != null) {
//                        mSendTime = System.currentTimeMillis();
//                        minaClient.sendMessage(HiproConf.clentid + "", MsgProc.DISCONNECT, "");
//                        minaClient.disConnect();
//                        minaClient = null;
//                        mHandler_xintiao.removeCallbacks(mHeartbeatRunnable);
//                        MyService.connState = 0;
//                        HiproConf.WifiLian_State = 0;
//                    }
//                    break;
                case MESSAGE_AP_STATE_ENABLED:

                    LogUtil.d("fkwifi");

                    String ssid = WifiAPUtil.getInstance(context).getValidApSsid();
                    String pw = WifiAPUtil.getInstance(context).getValidPassword();
                    int security = WifiAPUtil.getInstance(context).getValidSecurity();
                    String s = "wifi热点开启成功" + ","
                            + "SSID:" + ssid + ","
                            + "Password :" + pw + ","
                            + "Security: " + security;
                    Log.d(HiproConf.tcpTag, s);
                    //开启TCPServer
                    mHandler.postDelayed(new Runnable() {

                        @Override
                        public void run() {
                            // TODO Auto-generated method stub

                            LogUtil.d("threadidstcp", Thread.currentThread().getId() + "");

                            if (createServerTag) {
                                createServer();

                                createServerTag = false;
                            }

                        }
                    }, 15 * 1000);

                    break;
                case MESSAGE_AP_STATE_FAILED:
                    Log.d("wifiAp", "wifi热点关闭");
                    break;
                case WIFI_CHANNEL_RECEIVE:
                    String tc = (String) msg.obj;
                    Log.d(HiproConf.tcpTag, "接收通道信息:" + tc);
                    //if(HiproConf.channels_Wifi. )
//                    if (!HiproConf.channels_Wifi.contains(tc)) {
//                        HiproConf.channels_Wifi.add(tc);
//                    }
//                    sendToClent(WIFI_CHANNEL_RECEIVE, 0, 0, tc);
                    break;
                case WIFI_DATA_RECEIVE:
                    //ByteDataTcp tempd = (ByteDataTcp)msg.obj;

                    Bundle b = (Bundle) msg.obj;
//						b.putString("channel_name",tempd.getChannel_name());
//						b.putByteArray("ins_data", hexStringToByte(tempd.getIns_data_string()));
//						b.putString("ins_data_string", tempd.getIns_data_string());
//						b.putInt("ins_code", tempd.getIns_code());
                    Log.d(HiproConf.tcpTag, "wifi handler 收到指令，数据：" + BluetoothLeService.Bytes2HexString(b.getByteArray("ins_data")) + ",channel:" + b.getString("channel_name"));
                    sendData(b);
                    break;
                case WIFI_CLENT_DATA_RECEIVE:
                    byte[] v = (byte[]) msg.obj;
                    writeData(v);
                    break;


                default:
                    break;
            }
        }
    };


    private void printTestResultList(ArrayList<ShowResData> resList) {

        if (resList.size() == 0) return;
        //打印通道
        ShowResData pdata = resList.get(0);

//        ArrayList<byte[]> l = HsCrpDoubleResultPrintData.getPrintList("通道"+pdata.getChannel() + pdata.getXiangmu()+"-"+pdata.getXingneng() + "开始" + "\n");
        printRes(getBytesListTest("通道" + pdata.getChannel() + pdata.getXiangmu() + "-" + pdata.getXingneng(), resList));

//        for (ShowResData tdata : resList) {
//            printTestResult(tdata);
//        }
//
//        l = HsCrpDoubleResultPrintData.getPrintListSimgle("END  " + pdata.getChannel());
//        printRes(l);
//        l = HsCrpDoubleResultPrintData.getPrintListSimgle(" \n");
//        printRes(l);
//        printRes(l);
//        printRes(l);
//        printRes(l);
//        printRes(l);
    }

    private void printTestResult(ShowResData pdata) {
        String timeStr = "Time:" + pdata.getTestTime() + "\n";
        String valueStr = "Value:" + pdata.getTestValue() + "\n";
        ArrayList<byte[]> l = HsCrpDoubleResultPrintData.getPrintList(timeStr);
        printRes(l);


        l = HsCrpDoubleResultPrintData.getPrintListSimgle(valueStr);
        printRes(l);

        l = HsCrpDoubleResultPrintData.getPrintListSimgle("  ");
        printRes(l);
    }

    private void printRes(ArrayList<byte[]> l) {
        if (HiproConf.bluetoothVer != 0) {
            printList.addAll(printList.size(), l);
        } else {
            printData(l);
        }
    }

    /**
     * 选择wifi模式
     */
    private void ini_WifiMod() {
        try {
            Bundle b;
            Log.d(HiproConf.tcpTag, ",ini_WifiMod()");
            destryWifi();
            if (HiproConf.WifiMod == 1) {//主机模式
                startServerMod();
//                wifiMonitor();
            } else if (HiproConf.WifiMod == 2) {//从机模式
                startClentMod();
//                wifiMonitor();
            }
        } catch (Exception e) {

        }


    }

    private void destryWifi() {
        if (mHandler_xintiao != null) {
            mHandler_xintiao.removeCallbacks(mHeartbeatRunnable);
        }

        if (minaServer != null) {
            for (String key : Constant.sessionMap.keySet()) {
                minaServer.sendMessage(key, MsgProc.DISCONNECT, "");
            }
            minaServer.disConnect();
            minaServer = null;
        }
        if (minaClient != null) {
            minaClient.disConnect();
            minaClient = null;
        }
    }

    /**
     * wifi变化监听
     */
    private void wifiMonitor() {
        try {
            wifiReceiver = WifiChangedReceiver.registerWifiChangeReceiver(context);
            wifiReceiver.setListener(new WifiChangedReceiver.WifiChangeListener() {
                @Override
                public void onDisabled() {//wifi关闭
                    if (HiproConf.WifiMod == 2) {//从机模式
                        sendToClent(WIFI_BREAK_OFF, 0, 0, null);
                    }
                }

                @Override
                public void onConnected() {//wifi连接
                    if (HiproConf.WifiMod == 1) {//主机
                        sendToClent(WIFI_CONNECT, 0, 0, null);
                    }
                }

                @Override
                public void onConnectedServer(boolean isServer) {

                }
            });


        } catch (Exception e) {


        }

    }

    private void startServerMod() {
        Log.d(HiproConf.tcpTag, ",startServerMod()");
        startWIFIAP();

//        executorRunEvent.execute(new Runnable() {
//            @Override
//            public void run() {
//
//
//            }
//        });



    }



    private void startWIFIAP() {
        Log.d(HiproConf.tcpTag, ",startWIFIAP()");
        //初始化热点
//        ini_WifiAPUtil();
        //开启热点
//        boolean bx = WifiAPUtil.getInstance(context).turnOnWifiAp(HiproConf.WIFI_SERVER_SSID, HiproConf.WIFI_SERVER_PSW, WifiAPUtil.WifiSecurityType.WIFICIPHER_WPA);
//        Log.d(HiproConf.tcpTag, "WifiAp 开启：" + bx);
        WifiControlUtils.getInstance(this).closeWifi();
//        top.cuihp.serverlibrary.wifi.WifiAPUtil.getInstance(context).setWifiApEnabled(false);//关闭热点
        //设置热点
        Log.d(HiproConf.tcpTag, "热点的打开状态前 ：");
        top.cuihp.serverlibrary.wifi.WifiAPUtil.getInstance(context).turnOnWifiAp(WifiConfig.SSID, WifiConfig.PWD, top.cuihp.serverlibrary.wifi.WifiAPUtil.WifiSecurityType.WIFICIPHER_WPA);

//        try {
//            Log.d(HiproConf.tcpTag, "热点的打开状态前11");
//            ServerSocket serverSockets = new ServerSocket(8888);
//           //监听10001端口
//            Socket socket = serverSockets.accept();//接收客户端请求
//            Log.d(HiproConf.tcpTag, "热点的打开状态前222");
//            PrintStream pStream = new PrintStream(socket.getOutputStream());//取得客户端输出流
//           //字符缓冲区读取
//            BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
//            StringBuffer infoStr = new StringBuffer();
//            infoStr.append("Android:");//回应数据
//            infoStr.append(reader.readLine());//接收数据
//            pStream.print(infoStr);//发送消息
//
//            pStream.close();
//            reader.close();
//            serverSockets.close();
//            socket.close();
//
//        } catch (IOException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }


//        boolean redian2 = top.cuihp.serverlibrary.wifi.WifiAPUtil.getInstance(context).turnOnWifiAp(WifiConfig.SSID, WifiConfig.PWD, top.cuihp.serverlibrary.wifi.WifiAPUtil.WifiSecurityType.WIFICIPHER_WPA);
        Log.d(HiproConf.tcpTag, "热点的打开状态：" );
        //服务器初始化
        ServerConfig serverConfig = new ServerConfig.Builder().setPort(8888).build();
        minaServer = new MinaServer(serverConfig);
        minaServer.setServerStateListener(new MinaServer.ServerStateListener() {
            @Override
            public void sessionCreated() {
                Log.d(HiproConf.tcpTag, "server sessionCreated ");
//                    String sampleIdError = context.getResources().getString(R.string.congjilianjie2);
//                    Toast.makeText(context, sampleIdError, Toast.LENGTH_SHORT).show();
            }

            @Override
            public void sessionOpened() {
                if (minaServer != null) {

                    Log.d(HiproConf.tcpTag, "server sessionOpened ");
//                        for (String key : Constant.sessionMap.keySet()) {
//                            minaServer.sendMessage(key, MsgProc.HANDLE_C, "");
//                        }
//                        minaServer.sendMessage(HiproConf.clentid + "", MsgProc.HANDLE_C, "");
                }


            }

            @Override
            public void sessionClosed() {
                Log.d(HiproConf.tcpTag, "server sessionClosed ");

                if (HiproConf.WifiMod == 1) {
//                    tcpMode.setSummary(getString(R.string.connected)+getString(R.string.client_num)+Constant.sessionMap.size());//在sessionClosed中删除map-session--这里做更新
                    Log.d(HiproConf.tcpTag, "" + Constant.sessionMap.size());
                }
            }


            @Override
            public void messageReceived(MsgBean msgBean) {
                if (msgBean == null) {
                    return;
                }
                Gson gson = new Gson();
//                    if(msgBean.getType()!=MsgProc.HEART_BEAT){
                Log.d(HiproConf.tcpTag, "server messageReceived " + msgBean.toString());
//                    }

                //---------------------测试-----------------
                /*isC = true;
                Log.e("TCP:","Server 关闭到可连接用时："+(System.currentTimeMillis()-disServerTime));*/

                switch (msgBean.getType()) {
                    case MsgProc.HANDLE_C_BACK:
//                        tcpMode.setSummary(getString(R.string.connected)+getString(R.string.client_num)+Constant.sessionMap.size());
                        Log.d(HiproConf.tcpTag, "HANDLE_C_BACK:" + Constant.sessionMap.size());
                        break;
                    case MsgProc.HANDLE://握手成功
//                        tcpMode.setSummary(getString(R.string.connected)+getString(R.string.client_num)+Constant.sessionMap.size());
                        if (minaServer != null) {
                            minaServer.sendMessage(msgBean.getDeviceId(), MsgProc.HANDLE_BACK, "handle back");
                            Log.d(HiproConf.tcpTag, "HANDLE:" + Constant.sessionMap.size());
                            String sampleIdError = context.getResources().getString(R.string.congjilianjie);
                            if (!mapsClient.containsKey(msgBean.getDeviceId())) {
                                Toast.makeText(context, String.format(sampleIdError, msgBean.getDeviceId()), Toast.LENGTH_SHORT).show();
                            }
                            mapsClient.put(msgBean.getDeviceId(), true);
                            mapsClient1.put(msgBean.getDeviceId(), System.currentTimeMillis());
                        }
                        break;

                    case MsgProc.SEND_MSG_BACK://收到消息反馈
                        if (minaServer != null) {
                            Log.d(HiproConf.tcpTag, "server msg back ok" + msgBean.getMsg());

                            addMessage(Long.parseLong(msgBean.getMsg()), true);
//                                minaServer.sendMessage(msgBean.getDeviceId(), MsgProc.SEND_MSG_BACK, msgBean.getMsg().split(fengefu)[0]);
//                                if (msgBean.getDeviceId().startsWith("HP") && msgBean.getDeviceId().length() == 13 || msgBean.getDeviceId().length() == 15) {//仪器发来的消息
//                                    Log.d(HiproConf.tcpTag, "主机转发上传Lis:" + msgBean.getMsg());
////                            SerialPortManager.getInstance().sendToLisServer(DataUtil.hexToByteArray(msgBean.getMsg()), LisHelper.getInstance(this));//Lis上传
//                                }
                        }
                        break;
                    case MsgProc.DISCONNECT:
                        mapsClient.put(msgBean.getDeviceId(), false);
                        int cx = Integer.parseInt(msgBean.getDeviceId());
                        String sampleIdError1 = context.getResources().getString(R.string.congjiduankai);
                        Toast.makeText(context, String.format(sampleIdError1, msgBean.getDeviceId()), Toast.LENGTH_SHORT).show();
                        templist = gson.fromJson(msgBean.getMsg(), new TypeToken<List<String>>() {
                        }.getType());
                        try {
                            mapsClient.remove(msgBean.getDeviceId());
                        } catch (Exception exception) {

                        }
                        String tt = cx + "";
                        if (cx < 10) tt = "0" + tt;
                        String tempc = "";
                        for (String c : templist) {
                            if (c.toUpperCase().contains("A")) {
                                tempc = tt + "A";
                            } else if (c.toUpperCase().contains("B")) {
                                tempc = tt + "B";
                            } else if (c.toUpperCase().contains("C")) {
                                tempc = tt + "C";
                            }
                            sendToClent(MyService.WIFI_ACTIVE_BREAK_OFF, cx, 0, tempc);
                            tempc = "";
                        }
                        break;
                    case MsgProc.ByteData_Send:
                        try {

                            if (minaServer != null) {
                                minaServer.sendMessage(msgBean.getDeviceId(), MsgProc.SEND_MSG_BACK, msgBean.getMsg().split(fengefu)[0]);
                            }
                            mapsClient.put(msgBean.getDeviceId(), true);
                            String neirong = msgBean.getMsg().split(fengefu)[1];
                            Log.d(HiproConf.tcpTag, neirong);
                            ByteDataTcp bx = gson.fromJson(neirong, ByteDataTcp.class);
                            Log.d(HiproConf.tcpTag, "Wifi 收到数据:" + bx.getIns_data_string() + ",clentno:" + msgBean.getDeviceId());
                            Bundle b = new Bundle();
                            b.putString("channel_name", bx.getChannel_name());
                            b.putByteArray("ins_data", hexStringToByte(bx.getIns_data_string()));
                            b.putString("ins_data_string", bx.getIns_data_string());
                            b.putInt("ins_code", bx.getIns_code());
                            sendData(b);
                        } catch (Exception exception) {
                            Log.e(HiproConf.tcpTag, "接收数据有问题" + msgBean.getDeviceId());
                        }
                        break;
                    case MsgProc.Channel_Conn:
                        if (minaServer != null) {

                            mapsClient.put(msgBean.getDeviceId(), true);
                            int cx1 = Integer.parseInt(msgBean.getDeviceId());
                            templist = gson.fromJson(msgBean.getMsg().split(fengefu)[1], new TypeToken<List<String>>() {
                            }.getType());
                            String tt1 = cx1 + "";
                            if (cx1 < 10) {
                                tt1 = "0" + tt1;
                            }
                            String tempc1 = "";
                            for (String c : templist) {
                                if (c.toUpperCase().contains("A")) {
                                    tempc1 = tt1 + "A";
                                } else if (c.toUpperCase().contains("B")) {
                                    tempc1 = tt1 + "B";
                                } else if (c.toUpperCase().contains("C")) {
                                    tempc1 = tt1 + "C";
                                }
                                if (minaServer != null) {
                                    minaServer.sendMessage(msgBean.getDeviceId(), MsgProc.SEND_MSG_BACK, msgBean.getMsg().split(fengefu)[0]);
                                    //乔 5.25 1是 0不是
                                    if (HiproConf.isPushData) {
//                                            minaServer.sendMessage(msgBean.getDeviceId(), MsgProc.ByteData_MAIBURUI, tempc1 + "," + "1");
                                        biaoshi++;
                                        addMessage(biaoshi, false);
                                        sendTcpServerMessage(msgBean.getDeviceId(), MsgProc.ByteData_MAIBURUI, biaoshi + fengefu + tempc1 + "," + "1");
                                    } else {
//                                            minaServer.sendMessage(msgBean.getDeviceId(), MsgProc.ByteData_MAIBURUI, tempc1 + "," + "0");
                                        biaoshi++;
                                        addMessage(biaoshi, false);
                                        sendTcpServerMessage(msgBean.getDeviceId(), MsgProc.ByteData_MAIBURUI, biaoshi + fengefu + tempc1 + "," + "0");
                                    }
                                }
                                sendToClent(MyService.WIFI_CHANNEL_RECEIVE, 0, 0, tempc1);
                                tempc1 = "";
                            }

                        }
                        break;
                    case MsgProc.HEART_BEAT:

                        if (mapsClient1.containsKey(msgBean.getDeviceId())) {
                            //发送间隔1秒
                            if (System.currentTimeMillis() - mapsClient1.get(msgBean.getDeviceId()) >= 5 * 1000) {
                                if (minaServer != null) {
                                    minaServer.sendMessage(msgBean.getDeviceId(), MsgProc.HEART_BEAT, "");
                                    mapsClient1.put(msgBean.getDeviceId(), System.currentTimeMillis());
                                }

                            }
                        } else {

                            if (minaServer != null) {
                                mapsClient1.put(msgBean.getDeviceId(), System.currentTimeMillis());
                                minaServer.sendMessage(msgBean.getDeviceId(), MsgProc.HEART_BEAT, "");

                            }
                        }


                        break;
                }
                mapsClientZhu.put(msgBean.getDeviceId(), 0);
                mapsClient.put(msgBean.getDeviceId(), true);
//                minaServer.sendMessage(message+"收到回复 by server");
            }

            @Override
            public void messageSent(String message) {
//                    Log.d(HiproConf.tcpTag, "server messageSent " + message);

            }
        });
        mHandler_xintiao.postDelayed(mHeartbeatRunnable, HEART_BEAT_RATE);



    }

    private volatile boolean servRuning = false;

    private boolean createServer() {
        Log.d(HiproConf.tcpTag, ",createServer()");
        Log.d(HiproConf.tcpTag, "connectserver, wifiMod:" + HiproConf.WifiMod + ",servRuning:" + servRuning);
        if (HiproConf.WifiMod != 1) return false;
        if (servRuning) return true;

        if (tcpserver == null) {
            tcpserver = new MyTcpServer();
        }

        tcpserver.setHandler(mHandler);
        try {
            tcpserver.startServer();
            servRuning = true;
            Log.d(HiproConf.tcpTag, "服务端启动监听");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            Log.d(HiproConf.tcpTag, "服务端启动监听异常：" + e.toString());
            e.printStackTrace();
            return false;
        }
        //Log.d(HiproConf.tcpTag, "服务端启动监听");
        return true;
    }

    private void ini_WifiAPUtil() {
        //初始化WifiAPUtil类
        WifiAPUtil.getInstance(getApplicationContext());
        //注册handler
        WifiAPUtil.getInstance(this).regitsterHandler(mHandler);
    }

    private volatile int conntimes = 0;

    private void startClentMod() {
//		connectserver();
        conntimes = 0;
//        Thread cc = new Thread(new Runnable() {
//
//            @Override
//            public void run() {
//                // TODO Auto-generated method stub
//
//                Log.d(HiproConf.tcpTag, "startClentMod");
////                connState = 1;
//
//
//            }
//        });
//        cc.start();
        connectWIFI_AP(false);
    }

    //Hearbeat time
    private long mSendTime = 0L;
    //Heart rate
    private static final long HEART_BEAT_RATE = 1 * 60 * 1000;
    boolean isServerSuccess = false;
    boolean isServerSuccessZhu = false;
    boolean isServerSuccessCong = false;
    private int ServerFailCiShu = 0;
    private Map<String, Boolean> mapsClient = new ConcurrentHashMap<>();
    private Map<String, Long> mapsClient1 = new ConcurrentHashMap<>();
    private Map<String, Integer> mapsClientZhu = new ConcurrentHashMap<>();
    private Map<String, Integer> mapsClientCong = new ConcurrentHashMap<>();
    //For Heartbeat
    private Handler mHandler_xintiao = new Handler(Looper.getMainLooper());
    //Start Heartbeat thread
    private Runnable mHeartbeatRunnable = new Runnable() {
        @Override
        public void run() {
            Log.e(HiproConf.tcpTag, "发送心跳" + (System.currentTimeMillis() - mSendTime));
            long nage = 0;
//            if(HiproConf.WifiMod == 1){
            nage = HEART_BEAT_RATE;
//            }else {
//                nage=  isServerSuccessCong?HEART_BEAT_RATE:1000;
//            }
            if (System.currentTimeMillis() - mSendTime >= nage) {
                //发送心跳包
                //发送成功表示连接正常
                //发送失败表示socket连接断开，重启socket连接线程进行连接
                //sendHeartbeatPackage为发送数据
//                Log.e(HiproConf.tcpTag, "发送心跳"+(System.currentTimeMillis() - mSendTime));


                if (HiproConf.WifiMod == 1) {//主机模式
                    top.cuihp.serverlibrary.wifi.WifiAPUtil.getInstance(context).setWifiApEnabled(true);//打开热点
                    Log.e(HiproConf.tcpTag, "心跳----" + (minaServer != null) + "---mapsClient:" + mapsClient.toString());
                    if (minaServer != null) {
                        for (String key : Constant.sessionMap.keySet()) {
                            minaServer.sendMessage(key, MsgProc.HEART_BEAT, "");
                        }
                        for (String key : mapsClient.keySet()) {
                            boolean isClientSuccess = mapsClient.get(key);
                            if (!isClientSuccess) {
                                mapsClientZhu.put(key, mapsClientZhu.get(key) + 1);
                            }
                            if (mapsClientZhu.get(key) > 10) {
                                //release last socket
                                Log.e(HiproConf.tcpTag, "断开链接" + key);
                                int cx = Integer.parseInt(key);
                                String sampleIdError1 = context.getResources().getString(R.string.congjiduankai);
                                Toast.makeText(context, String.format(sampleIdError1, key), Toast.LENGTH_SHORT).show();

                                String tt = cx + "";
                                if (cx < 10) {
                                    tt = "0" + tt;
                                }
                                String tempc = "";

                                tempc = tt + "A";
                                sendToClent(MyService.WIFI_ACTIVE_BREAK_OFF, cx, 0, tempc);
                                tempc = tt + "B";
                                sendToClent(MyService.WIFI_ACTIVE_BREAK_OFF, cx, 0, tempc);
                                tempc = tt + "C";

                                sendToClent(MyService.WIFI_ACTIVE_BREAK_OFF, cx, 0, tempc);
                                mapsClient.remove(key);
                            }

                        }
                        for (String key : mapsClient.keySet()) {
                            if (mapsClient.get(key)) {
                                mapsClientZhu.put(key, 0);
                            }
                            mapsClient.put(key, false);

                        }
                    }


                } else if (HiproConf.WifiMod == 2) {//从机模式
                    Log.e(HiproConf.tcpTag, "心跳----" + (minaClient != null) + "---isServerSuccess:" + isServerSuccess);
                    if (minaClient != null) {
                        minaClient.sendMessage(HiproConf.clentid + "", MsgProc.HEART_BEAT, "");

                        if (!isServerSuccess) {
                            ServerFailCiShu = ServerFailCiShu + 1;
                            //release last socket

                        }
                        if (ServerFailCiShu > 15) {
//                            mHandler_xintiao.removeCallbacks(mHeartbeatRunnable);
//                            minaClient.disConnect();
//                            minaClient = null;
//                            MyService.connState = 0;
//                            HiproConf.WifiLian_State = 0;
//                            sendToClent(MyService.WIFI_ACTIVE_BREAK_OFF, 0, 0, "");
                            if(minaClient!=null){
                                top.cuihp.serverlibrary.wifi.WifiAPUtil.getInstance(context).setWifiApEnabled(false);//关闭热点
//        WifiAPUtil.getInstance(this).closeWifiAp();
                                WifiControlUtils.getInstance(context).openWifi();//打开wifi

                                //取消保存其他wifi
                                List<WifiConfiguration> wifies = WifiControlUtils.getInstance(context).getWifiConfigurationList();
                                if (wifies != null && wifies.size() > 0) {
                                    for (WifiConfiguration wifi : wifies) {
                                        if (!("\"" + WifiConfig.SSID + "\"").equals(wifi.SSID.substring(1, wifi.SSID.length() - 1))) {
                                            WifiControlUtils.getInstance(context).removeWifi(wifi.networkId);
                                        }
                                    }
                                }

                                WifiControlUtils.getInstance(context).addNetWork(WifiConfig.SSID, WifiConfig.PWD, WifiControlUtils.WIFI_CIPHER_WAP);//连接到server
                                if (HiproConf.WifiMod == 2) {
                                    destryWifi();
                                    connectWIFI_AP(true);
//                    tcpMode.setSummary(R.string.disconnect);//从机模式更新连接状态，点击禁用时收到回调（回调滞后）不更新
                                }
                            }
                        }
                        if (isServerSuccess) {
                            ServerFailCiShu = 0;
                        }

                        isServerSuccess = false;


                    }
                }
                //计算发送心跳包的时间
                mSendTime = System.currentTimeMillis();
                woshou = System.currentTimeMillis();


            }
            if (HiproConf.WifiMod == 1) {

                if (minaServer != null) {
                    //循环发送心跳包，3s一次
                    mHandler_xintiao.postDelayed(this, HEART_BEAT_RATE);
                }

            } else {
//
                if (minaClient != null) {
                    //循环发送心跳包，3s一次
                    mHandler_xintiao.postDelayed(this, HEART_BEAT_RATE);
                    isServerSuccessCong = false;
                }
            }


        }
    };
    //握手发送间隔时间
    private long woshou = 0L;


    private void connectWIFI_AP(final boolean isChongXin) {
        conntimes++;
        try {
            Log.d(HiproConf.tcpTag, "connectWIFI_AP");
//            WiFiAction myAction = new WiFiAction(context, mHandler);
//            myAction.connWifi(HiproConf.WIFI_SERVER_SSID, HiproConf.WIFI_SERVER_PSW, 3);

            top.cuihp.serverlibrary.wifi.WifiAPUtil.getInstance(context).setWifiApEnabled(false);//关闭热点
//        WifiAPUtil.getInstance(this).closeWifiAp();
            WifiControlUtils.getInstance(context).openWifi();//打开wifi

            //取消保存其他wifi
            List<WifiConfiguration> wifies = WifiControlUtils.getInstance(this).getWifiConfigurationList();
            if (wifies != null && wifies.size() > 0) {
                for (WifiConfiguration wifi : wifies) {
                    if (!("\"" + WifiConfig.SSID + "\"").equals(wifi.SSID.substring(1, wifi.SSID.length() - 1))) {
                        WifiControlUtils.getInstance(this).removeWifi(wifi.networkId);
                    }
                }
            }

            WifiControlUtils.getInstance(this).addNetWork(WifiConfig.SSID, WifiConfig.PWD, WifiControlUtils.WIFI_CIPHER_WAP);//连接到server
            try {
                Thread.sleep(3000);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            Constant.SERVER_IP = getDNS();
            Toast.makeText(context, Constant.SERVER_IP, Toast.LENGTH_SHORT).show();
            //客户端初始化
            ClientConfig clientConfig = new ClientConfig.Builder().setIp(Constant.SERVER_IP).setPort(Constant.SERVER_PORT).build();
            if (minaClient == null) {
                minaClient = new MinaClient(clientConfig);
                minaClient.setClientStateListener(new MinaClient.ClientStateListener() {
                    @Override
                    public void sessionCreated() {
                        Log.d(HiproConf.tcpTag, "client sessionCreated ");

                    }

                    @Override
                    public void sessionOpened() {
                        Log.d(HiproConf.tcpTag, "client sessionOpened ");
                        if (minaClient != null) {
                            mSendTime = System.currentTimeMillis();
                            minaClient.sendMessage(HiproConf.clentid + "", MsgProc.HANDLE, "");
                            connState =3;
                            sendToClent(WIFI_SERVER_CONN_STATE_CHANGE, connState, 0, null);
                            HiproConf.WifiLian_State = connState;
                        }

                    }

                    @Override
                    public void sessionClosed() {
                        Log.d(HiproConf.tcpTag, "client sessionClosed " + "tcpSta:" + HiproConf.WifiMod);

                        //证明是打开状态  当是null 证明用户关闭软件压
                        if(minaClient!=null){
                            top.cuihp.serverlibrary.wifi.WifiAPUtil.getInstance(context).setWifiApEnabled(false);//关闭热点
//        WifiAPUtil.getInstance(this).closeWifiAp();
                            WifiControlUtils.getInstance(context).openWifi();//打开wifi

                            //取消保存其他wifi
                            List<WifiConfiguration> wifies = WifiControlUtils.getInstance(context).getWifiConfigurationList();
                            if (wifies != null && wifies.size() > 0) {
                                for (WifiConfiguration wifi : wifies) {
                                    if (!("\"" + WifiConfig.SSID + "\"").equals(wifi.SSID.substring(1, wifi.SSID.length() - 1))) {
                                        WifiControlUtils.getInstance(context).removeWifi(wifi.networkId);
                                    }
                                }
                            }

                            WifiControlUtils.getInstance(context).addNetWork(WifiConfig.SSID, WifiConfig.PWD, WifiControlUtils.WIFI_CIPHER_WAP);//连接到server
                            if (HiproConf.WifiMod == 2) {
                                destryWifi();
                                connectWIFI_AP(true);
//                    tcpMode.setSummary(R.string.disconnect);//从机模式更新连接状态，点击禁用时收到回调（回调滞后）不更新
                            }
                        }

                    }

                    @Override
                    public void messageReceived(MsgBean msgBean) {
                        if (msgBean == null) {
                            return;
                        }
//                        if(msgBean.getType()!=MsgProc.HEART_BEAT){
                        Log.d(HiproConf.tcpTag, "client messageReceived " + msgBean.toString());
//                        }

                        isServerSuccess = true;
                        isServerSuccessCong = true;
                        ServerFailCiShu = 0;
                        switch (msgBean.getType()) {
                            case MsgProc.HANDLE_C://服务器握手
//                        tcpMode.setSummary(R.string.connected);
                                if (minaClient != null) {
                                    mSendTime = System.currentTimeMillis();
                                    minaClient.sendMessage(HiproConf.clentid + "", MsgProc.HANDLE_C_BACK, "");
                                }


                                break;
                            case MsgProc.HANDLE_BACK://握手成功
//                        tcpMode.setSummary(R.string.connected);
                                Log.d(HiproConf.tcpTag, "client handle ok");
                                if (TextUtils.equals(msgBean.getDeviceId(), "" + HiproConf.clentid)) {
                                    connState = 3;
                                    sendToClent(WIFI_SERVER_CONN_STATE_CHANGE, connState, 0, null);
                                    HiproConf.WifiLian_State = connState;
                                    isServerSuccess = true;
                                    mHandler_xintiao.postDelayed(mHeartbeatRunnable, HEART_BEAT_RATE);
                                }

                                break;
                            case MsgProc.SEND_MSG_BACK://收到消息成功
                                Log.d(HiproConf.tcpTag, "client msg back ok" + msgBean.getMsg());

                                addMessage(Long.parseLong(msgBean.getMsg()), true);

                                break;
                            case MsgProc.DISCONNECT:
                                if (HiproConf.WifiMod == 2) {
//                            tcpMode.setSummary(R.string.disconnect);//-----------------------------可不用
                                }
                                Log.d(HiproConf.tcpTag, "收到断开连接");
                                sendToClent(MyService.WIFI_ACTIVE_BREAK_OFF, 0, 0, "");
                                mHandler_xintiao.removeCallbacks(mHeartbeatRunnable);
                                minaClient = null;
                                MyService.connState = 0;
                                HiproConf.WifiLian_State = 0;

                                break;
                            case MsgProc.HEART_BEAT:
                                if (HiproConf.WifiMod == 2) {
//                            tcpMode.setSummary(R.string.disconnect);//-----------------------------可不用
                                }


                                if (System.currentTimeMillis() - woshou >= 10 * 1000) {
                                    try {
                                        if (minaClient != null) {
                                            mSendTime = System.currentTimeMillis();
                                            minaClient.sendMessage(HiproConf.clentid + "", MsgProc.HEART_BEAT, "");
                                            woshou = System.currentTimeMillis();
                                        }
                                    } catch (Exception E) {

                                    }


                                }
                                break;
                            //取消测试
                            case MsgProc.ByteData_QUXIAOCESHI:

                                String channel = msgBean.getMsg().split(fengefu)[1];

                                int jiqiBianHao = Integer.parseInt(channel.substring(0, channel.length() - 1));
                                Log.e(TAG, "需要取消的仪器编号：" + jiqiBianHao);
                                Log.e(TAG, "当前的仪器编号：" + HiproConf.clentid);
                                if (HiproConf.clentid == jiqiBianHao) {


                                    if (channel.toUpperCase().contains("A")) {
                                        sendToClent(MyService.WIFI_QUXIAOCESHI, 0, 0, "01A");
                                    } else if (channel.toUpperCase().contains("B")) {
                                        sendToClent(MyService.WIFI_QUXIAOCESHI, 0, 0, "01B");

                                    } else if (channel.toUpperCase().contains("C")) {
                                        sendToClent(MyService.WIFI_QUXIAOCESHI, 0, 0, "01C");

                                    }

                                    if (minaClient != null) {
                                        minaClient.sendMessage(HiproConf.clentid + "", MsgProc.SEND_MSG_BACK, msgBean.getMsg().split(fengefu)[0]);
                                    }

                                }

                                break;
                            //发送数据
                            case MsgProc.ByteData_FASONGSHUJV:
                                String[] jieguo1 = msgBean.getMsg().split(fengefu)[1].split(",");
                                String zifuchuan = jieguo1[0];
                                int zifuchuan_jiqiBianHao = Integer.parseInt(zifuchuan.substring(0, zifuchuan.length() - 1));
                                Log.e(TAG, "需要发送数据的仪器编号：" + zifuchuan_jiqiBianHao);
                                Log.e(TAG, "当前的仪器编号：" + HiproConf.clentid);
                                if (HiproConf.clentid == zifuchuan_jiqiBianHao) {
//                                    Toast.makeText(context,"让下位机执行动作",Toast.LENGTH_LONG).show();
                                    byte[] sendData = ByteCommon.hexStringToByte(jieguo1[1]);
                                    if (zifuchuan.toUpperCase().contains("A")) {
                                        sendData[1] = A3BLEProcessor.passAdress("01A");
                                        sendData[sendData.length - 2] = A3BLEProcessor.chenk_byte(sendData, 1, sendData.length - 3);

//                                        sendToClent(MyService.WIFI_QUXIAOCESHI, 0, 0, "01A");

                                    } else if (zifuchuan.toUpperCase().contains("B")) {
                                        sendData[1] = A3BLEProcessor.passAdress("01B");
                                        sendData[sendData.length - 2] = A3BLEProcessor.chenk_byte(sendData, 1, sendData.length - 3);
//                                        sendToClent(MyService.WIFI_QUXIAOCESHI, 0, 0, "01B");

                                    } else if (zifuchuan.toUpperCase().contains("C")) {
                                        sendData[1] = A3BLEProcessor.passAdress("01C");
                                        sendData[sendData.length - 2] = A3BLEProcessor.chenk_byte(sendData, 1, sendData.length - 3);
//                                        sendToClent(MyService.WIFI_QUXIAOCESHI, 0, 0, "01C");
                                    }
                                    try {
                                        Message msg = new Message();
                                        msg.what = DEVICE_DATA_SEND;
                                        msg.obj = sendData;
                                        if (clentHandler != null) {
                                            Log.e(TAG, "发送下位机指令");
                                            clentHandler.sendMessage(msg);
                                        }
                                        if (minaClient != null) {
                                            minaClient.sendMessage(HiproConf.clentid + "", MsgProc.SEND_MSG_BACK, msgBean.getMsg().split(fengefu)[0]);
                                        }
                                    } catch (Exception exception) {
                                        exception.printStackTrace();
                                    }


                                }

                                break;
                              //发送数据
                            case MsgProc.ByteData_FASONGSHUJV_1:
                                String[] jieguo2 = msgBean.getMsg().split(fengefu)[1].split(",");
                                String zifuchuan2 = jieguo2[0];
                                int zifuchuan_jiqiBianHao2 = Integer.parseInt(zifuchuan2.substring(0, zifuchuan2.length() - 1));
                                Log.e(TAG, "需要发送下位机结果的仪器编号：" + zifuchuan_jiqiBianHao2);
                                Log.e(TAG, "当前的仪器编号：" + HiproConf.clentid);
                                if (HiproConf.clentid == zifuchuan_jiqiBianHao2) {
//                                    Toast.makeText(context,"让下位机执行动作",Toast.LENGTH_LONG).show();
                                    byte[] sendData = ByteCommon.hexStringToByte(jieguo2[1]);
                                    if (zifuchuan2.toUpperCase().contains("A")) {
                                        sendData[1] = A3BLEProcessor.passAdress("01A");
                                        sendData[sendData.length - 2] = A3BLEProcessor.chenk_byte(sendData, 1, sendData.length - 3);

//                                        sendToClent(MyService.WIFI_QUXIAOCESHI, 0, 0, "01A");

                                    } else if (zifuchuan2.toUpperCase().contains("B")) {
                                        sendData[1] = A3BLEProcessor.passAdress("01B");
                                        sendData[sendData.length - 2] = A3BLEProcessor.chenk_byte(sendData, 1, sendData.length - 3);
//                                        sendToClent(MyService.WIFI_QUXIAOCESHI, 0, 0, "01B");

                                    } else if (zifuchuan2.toUpperCase().contains("C")) {
                                        sendData[1] = A3BLEProcessor.passAdress("01C");
                                        sendData[sendData.length - 2] = A3BLEProcessor.chenk_byte(sendData, 1, sendData.length - 3);
//                                        sendToClent(MyService.WIFI_QUXIAOCESHI, 0, 0, "01C");
                                    }
                                    try {
                                        Message msg = new Message();
                                        msg.what = DEVICE_DATA_SEND;
                                        msg.obj = sendData;
                                        if (clentHandler != null) {
                                            Log.e(TAG, "发送下位机指令");
                                            clentHandler.sendMessage(msg);
                                        }
                                        if (minaClient != null) {
                                            minaClient.sendMessage(HiproConf.clentid + "", MsgProc.SEND_MSG_BACK, msgBean.getMsg().split(fengefu)[0]);
                                        }
                                    } catch (Exception exception) {
                                        exception.printStackTrace();
                                    }


                                }

                                break;
                            case MsgProc.ByteData_TESTRESLUT:

                                try {
                                    String[] jieguo = msgBean.getMsg().split(fengefu)[1].split(",");
                                    String channel1 = jieguo[0];

                                    int jiqiBianHao1 = Integer.parseInt(channel1.substring(0, channel1.length() - 1));
                                    Log.e(TAG, "发送测试结果：" + jiqiBianHao1);
                                    Log.e(TAG, "当前的仪器编号：" + HiproConf.clentid);
                                    if (HiproConf.clentid == jiqiBianHao1) {
                                        byte[] sdatajieguo = null;
                                        if (channel1.toUpperCase().contains("A")) {
                                            if (jieguo.length == 4) {
                                                sdatajieguo = A3BLEProcessor.bulidResultDown("01A", Float.parseFloat(jieguo[1]), Float.parseFloat(jieguo[2]), Float.parseFloat(jieguo[3]));

//                                              sendToClent(MyService.WIFI_FASONGCESHIJIEGUO, 0, 0, "01A"+","+jieguo[1]+","+jieguo[2]+","+jieguo[3]);
                                            }

                                        } else if (channel1.toUpperCase().contains("B")) {
                                            if (jieguo.length == 4) {
//                                              sendToClent(MyService.WIFI_FASONGCESHIJIEGUO, 0, 0, "01B"+","+jieguo[1]+","+jieguo[2]+","+jieguo[3]);
                                                sdatajieguo = A3BLEProcessor.bulidResultDown("01B", Float.parseFloat(jieguo[1]), Float.parseFloat(jieguo[2]), Float.parseFloat(jieguo[3]));
                                            }

                                        } else if (channel1.toUpperCase().contains("C")) {
                                            if (jieguo.length == 4) {
//                                              sendToClent(MyService.WIFI_FASONGCESHIJIEGUO, 0, 0, "01C"+","+jieguo[1]+","+jieguo[2]+","+jieguo[3]);
                                                sdatajieguo = A3BLEProcessor.bulidResultDown("01C", Float.parseFloat(jieguo[1]), Float.parseFloat(jieguo[2]), Float.parseFloat(jieguo[3]));
                                            }

                                        }
                                        if (sdatajieguo != null) {
                                            Log.e(TAG, "发送指令");
                                            Message msg = new Message();
                                            msg.what = DEVICE_DATA_SEND;
                                            msg.obj = sdatajieguo;
                                            if (clentHandler != null) {
                                                clentHandler.sendMessage(msg);
                                            }
                                            if (minaClient != null) {
                                                minaClient.sendMessage(HiproConf.clentid + "", MsgProc.SEND_MSG_BACK, msgBean.getMsg().split(fengefu)[0]);
                                            }
                                        }

                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }


                                break;
                            case MsgProc.ByteData_MAIBURUI:

                                try {
                                    String[] jieguo = msgBean.getMsg().split(fengefu)[1].split(",");
                                    String channelqudao = jieguo[0];

                                    int jiqiBianHaoqudao = Integer.parseInt(channelqudao.substring(0, channelqudao.length() - 1));
                                    Log.e(TAG, "是否进入买普瑞模式：" + jiqiBianHaoqudao);
                                    Log.e(TAG, "当前的仪器编号：" + HiproConf.clentid);
                                    if (HiproConf.clentid == jiqiBianHaoqudao) {
                                        byte[] sdatajieguo11 = null;


                                        if (channelqudao.toUpperCase().contains("A")) {
                                            if (jieguo.length == 2) {
//                                              sendToClent(MyService.WIFI_SHIFOUMAIBURUI, 0, 0, "01A"+","+jieguo[1]);
                                                if (TextUtils.equals(jieguo[1], "1")) {
                                                    sdatajieguo11 = A3BLEProcessor.buildEnterMPR("01A");
                                                } else {
                                                    sdatajieguo11 = A3BLEProcessor.buildExitMPR("01A");
                                                }
                                            }

                                        } else if (channelqudao.toUpperCase().contains("B")) {
                                            if (jieguo.length == 2) {
//                                              sendToClent(MyService.WIFI_SHIFOUMAIBURUI, 0, 0, "01B"+","+jieguo[1]);
                                                if (TextUtils.equals(jieguo[1], "1")) {
                                                    sdatajieguo11 = A3BLEProcessor.buildEnterMPR("01B");
                                                } else {
                                                    sdatajieguo11 = A3BLEProcessor.buildExitMPR("01B");
                                                }
                                            }

                                        } else if (channelqudao.toUpperCase().contains("C")) {
                                            if (jieguo.length == 2) {
//                                              sendToClent(MyService.WIFI_SHIFOUMAIBURUI, 0, 0, "01C"+","+jieguo[1]);
                                                if (TextUtils.equals(jieguo[1], "1")) {
                                                    sdatajieguo11 = A3BLEProcessor.buildEnterMPR("01C");
                                                } else {
                                                    sdatajieguo11 = A3BLEProcessor.buildExitMPR("01C");
                                                }
                                            }

                                        }

                                        if (sdatajieguo11 != null) {
                                            Log.e(TAG, "发送指令");
                                            Message msg = new Message();
                                            msg.what = DEVICE_DATA_SEND;
                                            msg.obj = sdatajieguo11;
                                            if (clentHandler != null) {
                                                clentHandler.sendMessage(msg);
                                            }
                                            if (minaClient != null) {
                                                minaClient.sendMessage(HiproConf.clentid + "", MsgProc.SEND_MSG_BACK, msgBean.getMsg().split(fengefu)[0]);
                                            }
                                        }


                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }


                                break;
                        }
                    }

                    @Override
                    public void messageSent(String message) {
//                        Log.d(HiproConf.tcpTag, "client messageSent " + message);

                    }
                });
            }

            if (!isChongXin) {
                sendToClent(WIFI_SERVER_CONN_STATE_CHANGE, connState = 2, 0, null);
            }

            HiproConf.WifiLian_State = connState;
            mhandler.postDelayed(new Runnable() {
                @Override
                public void run() {
//                    Toast.makeText(context,"链接主机到两分钟了",Toast.LENGTH_LONG).show();
                    if (connState < 2) {
                        if (!isChongXin) {
                            sendToClent(WIFI_SERVER_CONN_STATE_CHANGE, connState = 0, 0, null);
                        } else {
                            connectWIFI_AP(isChongXin);
                        }


                    }else {
//                        if(connState==2){
//                            if (minaClient != null) {
//                                mSendTime = System.currentTimeMillis();
//                                minaClient.sendMessage(HiproConf.clentid + "", MsgProc.HANDLE, "");
//                                connState = 2;
//                                sendToClent(WIFI_SERVER_CONN_STATE_CHANGE, connState, 0, null);
//                                HiproConf.WifiLian_State = connState;
//                            }
//                        }

                    }
                }
            }, isChongXin ? 3 * 1000 : 2 * 60 * 1000);
        } catch (Exception ex) {
            Log.e(HiproConf.tcpTag, "connectWIFI_AP  error:" + ex.toString());
            ex.printStackTrace();
            Thread.currentThread();
            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
//			if(conntimes<10)
//				connectWIFI_AP();
        }
    }


    private void connectserver() {
        Log.d(HiproConf.tcpTag, "connectserver1, wifiMod:" + HiproConf.WifiMod);
        if (HiproConf.WifiMod != 2) return;
        connState = 2;
        MyService.connState = 0;
        tcpclent = new MyTcpClent();
        MyTcpClent.setHandler(mHandler);
        final int tempID = HiproConf.clentid;
        Thread tx = new Thread(new Runnable() {
            @Override
            public void run() {
                // TODO Auto-generated method stub
                try {
                    tcpclent.connectServer();
                    Log.d(HiproConf.tcpTag, "connectserver2");
                    TcpMessage msg = new TcpMessage();
                    msg.setMsgWaht(TcpProc.CONNSERVER);
                    msg.setMsgInt(tempID);
                    tcpclent.sendMsg(TcpProc.getMsgStr(msg));
                } catch (Exception ex) {
                    Log.e(HiproConf.tcpTag, "**********************");
                    Log.e(HiproConf.tcpTag, "Clent conn error:" + ex.toString());
                    ex.printStackTrace();
                    Log.e(HiproConf.tcpTag, "**********************");
                }
            }
        });
        tx.start();
    }

    private void sendtoServeClent(int ClentNo, TcpMessage msg) {
        if (MyTcpServer.serveRunning) {

            tcpserver.sendToClent(ClentNo, msg);
        }
    }

    public static void xiaohui() {

        //主机

        if (minaServer != null) {
            for (String key : Constant.sessionMap.keySet()) {
                Log.e(TAG, "告诉从机断开链接" + key);
                minaServer.sendMessage(key, MsgProc.DISCONNECT, "");
            }
            if (minaServer != null) {
                minaServer.disConnect();
            }

            minaServer = null;
        }


        //从机
        if (minaClient != null) {
            Log.e(TAG, "告诉主机断开链接");
            Gson gson = new Gson();
            minaClient.sendMessage(HiproConf.clentid + "", MsgProc.DISCONNECT, gson.toJson(templist));
            minaClient.disConnect();
            minaClient = null;
        }


    }

    public static void xiaohui_suo() {

//         Log.e("qiao","解锁"+(testLoc.tryLock()));
//    if(!testLoc.tryLock()){
//        Log.e("qiao","解锁");
//        testLoc.unlock();
//    }
//    if(!testControlLoc.tryLock()){
//        testControlLoc.unlock();
//    }


    }

    public static String getDNS() {
        String dns = "";
        Process process = null;
        try {
            process = Runtime.getRuntime().exec("getprop net.dns1");
            BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
            dns = in.readLine();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (process != null) {
                process.destroy();
            }
        }
        return dns;
    }

}
