.class public Ltrace/MethodTrace;
.super Ljava/lang/Object;
.source "MethodTrace.java"


# static fields
.field private static dataLimitLength:I

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
    .locals 6

    new-instance v2, Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    move-object v5, v2

    move-object v2, v5

    move-object v3, v5

    invoke-direct {v3}, Ljava/util/concurrent/locks/ReentrantReadWriteLock;-><init>()V

    sput-object v2, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    new-instance v2, Ljava/util/HashMap;

    move-object v5, v2

    move-object v2, v5

    move-object v3, v5

    invoke-direct {v3}, Ljava/util/HashMap;-><init>()V

    sput-object v2, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    new-instance v2, Ljava/util/HashMap;

    move-object v5, v2

    move-object v2, v5

    move-object v3, v5

    invoke-direct {v3}, Ljava/util/HashMap;-><init>()V

    sput-object v2, Ltrace/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    new-instance v2, Ljava/util/ArrayList;

    move-object v5, v2

    move-object v2, v5

    move-object v3, v5

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    sput-object v2, Ltrace/MethodTrace;->methods:Ljava/util/ArrayList;

    new-instance v2, Ljava/io/File;

    move-object v5, v2

    move-object v2, v5

    move-object v3, v5

    const-string v4, "/sdcard/trace/trace.txt"

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    sput-object v2, Ltrace/MethodTrace;->filePath:Ljava/io/File;

    new-instance v2, Ljava/io/File;

    move-object v5, v2

    move-object v2, v5

    move-object v3, v5

    const-string v4, "/sdcard/trace/runtimedump.txt"

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    sput-object v2, Ltrace/MethodTrace;->rtDataPath:Ljava/io/File;

    new-instance v2, Ljava/io/File;

    move-object v5, v2

    move-object v2, v5

    move-object v3, v5

    const-string v4, "/sdcard/trace/lock"

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    sput-object v2, Ltrace/MethodTrace;->dumpLock:Ljava/io/File;

    const v2, 0xffff

    sput v2, Ltrace/MethodTrace;->dataLimitLength:I

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    .line 137
    move-object v0, p0

    move-object v2, v0

    invoke-direct {v2}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static writeData(Ljava/lang/String;)V
    .locals 16
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 104
    move-object/from16 v0, p0

    :try_start_0
    sget-object v9, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface {v9}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/concurrent/locks/Lock;->lock()V

    .line 107
    sget-object v9, Ltrace/MethodTrace;->filePath:Ljava/io/File;

    invoke-virtual {v9}, Ljava/io/File;->length()J

    move-result-wide v9

    const/4 v11, 0x0

    int-to-long v11, v11

    cmp-long v9, v9, v11

    if-nez v9, :cond_0

    .line 108
    new-instance v9, Ljava/util/HashMap;

    move-object v14, v9

    move-object v9, v14

    move-object v10, v14

    invoke-direct {v10}, Ljava/util/HashMap;-><init>()V

    sput-object v9, Ltrace/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    .line 111
    :cond_0
    sget-object v9, Ltrace/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    move-object v10, v0

    invoke-virtual {v9, v10}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_1

    .line 113
    sget-object v9, Ltrace/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    move-object v10, v0

    const/4 v11, 0x1

    new-instance v12, Ljava/lang/Boolean;

    move v14, v11

    move-object v15, v12

    move-object v11, v15

    move v12, v14

    move-object v13, v15

    move v14, v12

    move-object v15, v13

    move-object v12, v15

    move v13, v14

    invoke-direct {v12, v13}, Ljava/lang/Boolean;-><init>(Z)V

    invoke-virtual {v9, v10, v11}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v9

    .line 117
    :try_start_1
    new-instance v9, Ljava/io/FileWriter;

    move-object v14, v9

    move-object v9, v14

    move-object v10, v14

    sget-object v11, Ltrace/MethodTrace;->rtDataPath:Ljava/io/File;

    const/4 v12, 0x1

    invoke-direct {v10, v11, v12}, Ljava/io/FileWriter;-><init>(Ljava/io/File;Z)V

    move-object v6, v9

    .line 118
    new-instance v9, Ljava/io/BufferedWriter;

    move-object v14, v9

    move-object v9, v14

    move-object v10, v14

    move-object v11, v6

    invoke-direct {v10, v11}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    move-object v7, v9

    .line 121
    move-object v9, v7

    move-object v10, v0

    invoke-virtual {v9, v10}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 122
    move-object v9, v7

    invoke-virtual {v9}, Ljava/io/BufferedWriter;->newLine()V

    .line 125
    move-object v9, v7

    invoke-virtual {v9}, Ljava/io/BufferedWriter;->flush()V

    .line 126
    move-object v9, v7

    invoke-virtual {v9}, Ljava/io/BufferedWriter;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 135
    :cond_1
    :goto_0
    sget-object v9, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface {v9}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    .line 126
    :catch_0
    move-exception v9

    move-object v6, v9

    .line 128
    move-object v9, v6

    :try_start_2
    invoke-virtual {v9}, Ljava/io/IOException;->printStackTrace()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto :goto_0

    :catch_1
    move-exception v9

    move-object v6, v9

    .line 133
    move-object v9, v6

    :try_start_3
    invoke-virtual {v9}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v9

    move-object v2, v9

    .line 135
    sget-object v9, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface {v9}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v9

    invoke-interface {v9}, Ljava/util/concurrent/locks/Lock;->unlock()V

    move-object v9, v2

    throw v9
.end method

.method public static writeRTData(Ljava/lang/CharSequence;)V
    .locals 15
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/CharSequence;",
            ")V"
        }
    .end annotation

    .prologue
    .line 93
    move-object v0, p0

    sget-object v6, Ltrace/MethodTrace;->dumpLock:Ljava/io/File;

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v6

    if-nez v6, :cond_0

    move-object v6, v0

    if-nez v6, :cond_1

    .line 99
    :cond_0
    :goto_0
    return-void

    .line 95
    :cond_1
    move-object v6, v0

    invoke-interface {v6}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v6

    move-object v2, v6

    .line 96
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

    move-object v3, v6

    .line 97
    const-string v6, "@UIText| %s ==>\t%s"

    const/4 v7, 0x2

    new-array v7, v7, [Ljava/lang/Object;

    move-object v14, v7

    move-object v7, v14

    move-object v8, v14

    const/4 v9, 0x0

    move-object v10, v3

    invoke-virtual {v10}, Ljava/lang/StackTraceElement;->toString()Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v9

    move-object v14, v7

    move-object v7, v14

    move-object v8, v14

    const/4 v9, 0x1

    move-object v10, v2

    const/4 v11, 0x0

    move-object v12, v2

    invoke-virtual {v12}, Ljava/lang/String;->length()I

    move-result v12

    sget v13, Ltrace/MethodTrace;->dataLimitLength:I

    invoke-static {v12, v13}, Ljava/lang/Math;->min(II)I

    move-result v12

    invoke-virtual {v10, v11, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    move-object v4, v6

    .line 99
    move-object v6, v4

    invoke-static {v6}, Ltrace/MethodTrace;->writeData(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static writeRTData(Ljava/lang/String;)V
    .locals 14
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 72
    move-object v0, p0

    sget-object v5, Ltrace/MethodTrace;->dumpLock:Ljava/io/File;

    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v5

    if-nez v5, :cond_0

    move-object v5, v0

    if-nez v5, :cond_1

    .line 78
    :cond_0
    :goto_0
    return-void

    .line 75
    :cond_1
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

    .line 76
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

    sget v12, Ltrace/MethodTrace;->dataLimitLength:I

    invoke-static {v11, v12}, Ljava/lang/Math;->min(II)I

    move-result v11

    invoke-virtual {v9, v10, v11}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v9

    aput-object v9, v7, v8

    invoke-static {v5, v6}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    move-object v3, v5

    .line 78
    move-object v5, v3

    invoke-static {v5}, Ltrace/MethodTrace;->writeData(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static writeRTData([Ljava/lang/String;)V
    .locals 15
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 82
    move-object v0, p0

    sget-object v6, Ltrace/MethodTrace;->dumpLock:Ljava/io/File;

    invoke-virtual {v6}, Ljava/io/File;->exists()Z

    move-result v6

    if-nez v6, :cond_0

    move-object v6, v0

    if-nez v6, :cond_1

    .line 89
    :cond_0
    :goto_0
    return-void

    .line 85
    :cond_1
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

    move-object v2, v6

    .line 86
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

    move-object v3, v6

    .line 87
    const-string v6, "@General[]| %s ==>\t%s"

    const/4 v7, 0x2

    new-array v7, v7, [Ljava/lang/Object;

    move-object v14, v7

    move-object v7, v14

    move-object v8, v14

    const/4 v9, 0x0

    move-object v10, v3

    invoke-virtual {v10}, Ljava/lang/StackTraceElement;->toString()Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v9

    move-object v14, v7

    move-object v7, v14

    move-object v8, v14

    const/4 v9, 0x1

    move-object v10, v2

    const/4 v11, 0x0

    move-object v12, v2

    invoke-virtual {v12}, Ljava/lang/String;->length()I

    move-result v12

    sget v13, Ltrace/MethodTrace;->dataLimitLength:I

    invoke-static {v12, v13}, Ljava/lang/Math;->min(II)I

    move-result v12

    invoke-virtual {v10, v11, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    move-object v4, v6

    .line 89
    move-object v6, v4

    invoke-static {v6}, Ltrace/MethodTrace;->writeData(Ljava/lang/String;)V

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
    .line 19
    move-object/from16 v2, p0

    sget-object v19, Ltrace/MethodTrace;->dumpLock:Ljava/io/File;

    invoke-virtual/range {v19 .. v19}, Ljava/io/File;->exists()Z

    move-result v19

    if-eqz v19, :cond_0

    .line 67
    :goto_0
    return-void

    .line 23
    :cond_0
    :try_start_0
    sget-object v19, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v19

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/Lock;->lock()V

    .line 26
    sget-object v19, Ltrace/MethodTrace;->filePath:Ljava/io/File;

    invoke-virtual/range {v19 .. v19}, Ljava/io/File;->length()J

    move-result-wide v19

    const/16 v21, 0x0

    move/from16 v0, v21

    int-to-long v0, v0

    move-wide/from16 v21, v0

    cmp-long v19, v19, v21

    if-nez v19, :cond_1

    .line 27
    new-instance v19, Ljava/util/HashMap;

    move-object/from16 v30, v19

    move-object/from16 v19, v30

    move-object/from16 v20, v30

    invoke-direct/range {v20 .. v20}, Ljava/util/HashMap;-><init>()V

    sput-object v19, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    .line 28
    new-instance v19, Ljava/util/ArrayList;

    move-object/from16 v30, v19

    move-object/from16 v19, v30

    move-object/from16 v20, v30

    invoke-direct/range {v20 .. v20}, Ljava/util/ArrayList;-><init>()V

    sput-object v19, Ltrace/MethodTrace;->methods:Ljava/util/ArrayList;

    .line 31
    :cond_1
    sget-object v19, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v20, v2

    invoke-virtual/range {v19 .. v20}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v19

    if-eqz v19, :cond_4

    sget-object v19, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v20, v2

    invoke-virtual/range {v19 .. v20}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v19

    check-cast v19, [Ljava/lang/Long;

    :goto_1
    move-object/from16 v8, v19

    .line 32
    move-object/from16 v19, v8

    const/16 v20, 0x0

    aget-object v19, v19, v20

    check-cast v19, Ljava/lang/Long;

    invoke-virtual/range {v19 .. v19}, Ljava/lang/Long;->longValue()J

    move-result-wide v19

    move-wide/from16 v9, v19

    .line 33
    move-object/from16 v19, v8

    const/16 v20, 0x1

    aget-object v19, v19, v20

    check-cast v19, Ljava/lang/Long;

    invoke-virtual/range {v19 .. v19}, Ljava/lang/Long;->longValue()J

    move-result-wide v19

    move-wide/from16 v11, v19

    .line 36
    sget-object v19, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

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

    .line 38
    :cond_2
    sget-object v19, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v20, v2

    invoke-virtual/range {v19 .. v20}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v19

    if-nez v19, :cond_3

    .line 39
    sget-object v19, Ltrace/MethodTrace;->methods:Ljava/util/ArrayList;

    move-object/from16 v20, v2

    invoke-virtual/range {v19 .. v20}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move-result v19

    .line 41
    :cond_3
    sget-object v19, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

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

    .line 45
    :try_start_1
    new-instance v19, Ljava/io/FileWriter;

    move-object/from16 v30, v19

    move-object/from16 v19, v30

    move-object/from16 v20, v30

    sget-object v21, Ltrace/MethodTrace;->filePath:Ljava/io/File;

    invoke-direct/range {v20 .. v21}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    move-object/from16 v13, v19

    .line 46
    new-instance v19, Ljava/io/BufferedWriter;

    move-object/from16 v30, v19

    move-object/from16 v19, v30

    move-object/from16 v20, v30

    move-object/from16 v21, v13

    invoke-direct/range {v20 .. v21}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    move-object/from16 v14, v19

    .line 49
    sget-object v19, Ltrace/MethodTrace;->methods:Ljava/util/ArrayList;

    check-cast v19, Ljava/util/Collection;

    invoke-interface/range {v19 .. v19}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v19

    move-object/from16 v15, v19

    .line 51
    :goto_2
    move-object/from16 v19, v15

    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->hasNext()Z

    move-result v19

    if-nez v19, :cond_5

    .line 55
    move-object/from16 v19, v14

    invoke-virtual/range {v19 .. v19}, Ljava/io/BufferedWriter;->flush()V

    .line 56
    move-object/from16 v19, v14

    invoke-virtual/range {v19 .. v19}, Ljava/io/BufferedWriter;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 67
    :goto_3
    sget-object v19, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v19

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/Lock;->unlock()V

    goto/16 :goto_0

    .line 31
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

    .line 62
    :catch_0
    move-exception v19

    move-object/from16 v8, v19

    .line 65
    move-object/from16 v19, v8

    :try_start_3
    invoke-virtual/range {v19 .. v19}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_3

    .line 49
    :cond_5
    move-object/from16 v19, v15

    :try_start_4
    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v19

    check-cast v19, Ljava/lang/String;

    move-object/from16 v17, v19

    .line 50
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

    sget-object v23, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

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

    sget-object v21, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

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

    .line 51
    move-object/from16 v19, v14

    invoke-virtual/range {v19 .. v19}, Ljava/io/BufferedWriter;->newLine()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto/16 :goto_2

    .line 56
    :catch_1
    move-exception v19

    move-object/from16 v13, v19

    .line 58
    move-object/from16 v19, v13

    :try_start_5
    invoke-virtual/range {v19 .. v19}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_3

    .line 62
    :cond_6
    sget-object v19, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

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

    .line 65
    :catchall_0
    move-exception v19

    move-object/from16 v4, v19

    .line 67
    sget-object v19, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v19

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/Lock;->unlock()V

    move-object/from16 v19, v4

    throw v19
.end method