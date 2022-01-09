private static void logger20220108(String s)
{
    String[] detail = s.split("#");
    int pos = Integer.valueOf(detail[1]);
    int cap = Integer.valueOf(detail[2]);
    long utime = System.currentTimeMillis() / 1000L;

    if(doseq20220108 == null)
        doseq20220108 = new long[cap];

    if(doseq20220108[pos] == 0 || utime - doseq20220108[pos] >= 1)
        doseq20220108[pos] = utime;
    else
        return;

    String[] cmd = {"sh", "-c", String.format("mkdir /sdcard/traceTmp & touch '/sdcard/traceTmp/%s._'", detail[0])};

    try{
       Runtime.getRuntime().exec(cmd);
        //Toast.makeText(this, String.valueOf(doseq20220108.charAt(1002)), 2000).show();
    }catch(Exception e){}
}
