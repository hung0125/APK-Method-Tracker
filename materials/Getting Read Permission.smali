#caller, put inside the method onCreate() located in the entry point
invoke-static {v0}, L[Insert current class here];->getPer()V

#method
.method private static getPer()V
    .registers 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 31
    move-object v0, p0

    move-object v2, v0

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/String;

    move-object v7, v3

    move-object v3, v7

    move-object v4, v7

    const/4 v5, 0x0

    const-string v6, "android.permission.READ_EXTERNAL_STORAGE"

    aput-object v6, v4, v5

    const/4 v4, 0x1

    invoke-static {v2, v3, v4}, Landroid/support/v4/app/ActivityCompat;->requestPermissions(Landroid/app/Activity;[Ljava/lang/String;I)V

    return-void
.end method
