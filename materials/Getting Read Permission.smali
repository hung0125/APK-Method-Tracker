#for the manifest file, add permission WRITE_EXTERNAL_STORAGE

#caller, put inside the method onCreate() located in the entry point
move-object v0, p0
invoke-static {v0}, Lxxx/xxx/xxx;->getPer(Landroid/app/Activity;)V
move-object p0, v0

#method
.method private static getPer(Landroid/app/Activity;)V
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/Activity;",
            ")V"
        }
    .end annotation

    .prologue
    .line 37
    move-object v0, p0

    move-object v3, v0

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/String;

    move-object v8, v4

    move-object v4, v8

    move-object v5, v8

    const/4 v6, 0x0

    const-string v7, "android.permission.WRITE_EXTERNAL_STORAGE"

    aput-object v7, v5, v6

    const/4 v5, 0x1

    invoke-static {v3, v4, v5}, Landroid/support/v4/app/ActivityCompat;->requestPermissions(Landroid/app/Activity;[Ljava/lang/String;I)V

    return-void
.end method
