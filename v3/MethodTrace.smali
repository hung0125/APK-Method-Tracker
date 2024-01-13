.class public Ltrace/MethodTrace;
.super Ljava/lang/Object;
.source "MethodTrace.java"


# static fields
.field private static cacheDir:Ljava/lang/String;

.field private static ctx:Landroid/content/Context;

.field private static dataLimitLength:I

.field private static docDir:Ljava/io/File;

.field private static dumpLock:Ljava/io/File;

.field private static final fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

.field private static filePath:Ljava/io/File;

.field private static host:Ljava/lang/String;

.field private static lastOnPause:J

.field private static lastTraceActivity:Ljava/lang/String;

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

.field private static recordEnabled:Z

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

    sput-object v2, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    new-instance v2, Ljava/util/HashMap;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    invoke-direct {v3}, Ljava/util/HashMap;-><init>()V

    sput-object v2, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    new-instance v2, Ljava/util/ArrayList;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    sput-object v2, Ltrace/MethodTrace;->methods:Ljava/util/ArrayList;

    sget-object v2, Landroid/os/Environment;->DIRECTORY_DOCUMENTS:Ljava/lang/String;

    invoke-static {v2}, Landroid/os/Environment;->getExternalStoragePublicDirectory(Ljava/lang/String;)Ljava/io/File;

    move-result-object v2

    sput-object v2, Ltrace/MethodTrace;->docDir:Ljava/io/File;

    new-instance v2, Ljava/io/File;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    sget-object v4, Ltrace/MethodTrace;->docDir:Ljava/io/File;

    const-string v5, "/trace/trace.txt"

    invoke-direct {v3, v4, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    sput-object v2, Ltrace/MethodTrace;->filePath:Ljava/io/File;

    new-instance v2, Ljava/io/File;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    sget-object v4, Ltrace/MethodTrace;->docDir:Ljava/io/File;

    const-string v5, "/trace/runtimedump.txt"

    invoke-direct {v3, v4, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    sput-object v2, Ltrace/MethodTrace;->rtDataPath:Ljava/io/File;

    new-instance v2, Ljava/io/File;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    sget-object v4, Ltrace/MethodTrace;->docDir:Ljava/io/File;

    const-string v5, "/trace/lock"

    invoke-direct {v3, v4, v5}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    sput-object v2, Ltrace/MethodTrace;->dumpLock:Ljava/io/File;

    const v2, 0xffff

    sput v2, Ltrace/MethodTrace;->dataLimitLength:I

    new-instance v2, Ljava/util/HashMap;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    invoke-direct {v3}, Ljava/util/HashMap;-><init>()V

    sput-object v2, Ltrace/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    new-instance v2, Ljava/lang/StringBuilder;

    move-object v6, v2

    move-object v2, v6

    move-object v3, v6

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    sput-object v2, Ltrace/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    const/4 v2, 0x0

    check-cast v2, Landroid/content/Context;

    sput-object v2, Ltrace/MethodTrace;->ctx:Landroid/content/Context;

    const-string v2, "/data/user/0/@PACKAGE_NAME@/cache/"

    sput-object v2, Ltrace/MethodTrace;->cacheDir:Ljava/lang/String;

    const/4 v2, 0x1

    sput-boolean v2, Ltrace/MethodTrace;->recordEnabled:Z

    const-wide/16 v2, 0x0

    sput-wide v2, Ltrace/MethodTrace;->lastOnPause:J

    const-string v2, ""

    sput-object v2, Ltrace/MethodTrace;->lastTraceActivity:Ljava/lang/String;

    const-string v2, "http://debugger2024.atwebpages.com"

    sput-object v2, Ltrace/MethodTrace;->host:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    .line 240
    move-object v0, p0

    move-object v2, v0

    invoke-direct {v2}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static doPartition(Ljava/lang/String;)Ljava/util/ArrayList;
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 143
    move-object v0, p0

    new-instance v8, Ljava/util/ArrayList;

    move-object v11, v8

    move-object v8, v11

    move-object v9, v11

    invoke-direct {v9}, Ljava/util/ArrayList;-><init>()V

    move-object v2, v8

    .line 145
    const v8, 0x7d000

    move v3, v8

    .line 146
    const/4 v8, 0x0

    move v4, v8

    .line 148
    :goto_0
    move v8, v4

    move-object v9, v0

    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v9

    if-lt v8, v9, :cond_0

    .line 155
    move-object v8, v2

    move-object v0, v8

    return-object v0

    .line 149
    :cond_0
    move v8, v4

    move v9, v3

    add-int/2addr v8, v9

    move-object v9, v0

    invoke-virtual {v9}, Ljava/lang/String;->length()I

    move-result v9

    invoke-static {v8, v9}, Ljava/lang/Math;->min(II)I

    move-result v8

    move v5, v8

    .line 150
    move-object v8, v0

    move v9, v4

    move v10, v5

    invoke-virtual {v8, v9, v10}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    move-object v6, v8

    .line 151
    move-object v8, v2

    move-object v9, v6

    invoke-virtual {v8, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move-result v8

    .line 152
    move v8, v5

    move v4, v8

    goto :goto_0
.end method

.method public static dump()V
    .locals 23
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 161
    :try_start_0
    sget-object v13, Ltrace/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-static {v13}, Ltrace/MethodTrace;->doPartition(Ljava/lang/String;)Ljava/util/ArrayList;

    move-result-object v13

    move-object v1, v13

    .line 163
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v13

    invoke-static {v13, v14}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v13

    move-object v2, v13

    .line 166
    const/4 v13, 0x1

    move v3, v13

    .line 167
    new-instance v13, Ljava/util/ArrayList;

    move-object/from16 v21, v13

    move-object/from16 v13, v21

    move-object/from16 v14, v21

    invoke-direct {v14}, Ljava/util/ArrayList;-><init>()V

    move-object v4, v13

    .line 168
    move-object v13, v1

    check-cast v13, Ljava/util/Collection;

    invoke-interface {v13}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v13

    move-object v5, v13

    .line 184
    :goto_0
    move-object v13, v5

    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z

    move-result v13

    if-nez v13, :cond_0

    .line 188
    move-object v13, v4

    check-cast v13, Ljava/util/Collection;

    invoke-interface {v13}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v13

    move-object v7, v13

    .line 190
    :goto_1
    move-object v13, v7

    invoke-interface {v13}, Ljava/util/Iterator;->hasNext()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v13

    if-nez v13, :cond_1

    .line 199
    :goto_2
    new-instance v13, Ljava/lang/StringBuilder;

    move-object/from16 v21, v13

    move-object/from16 v13, v21

    move-object/from16 v14, v21

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    sput-object v13, Ltrace/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    .line 200
    new-instance v13, Ljava/util/HashMap;

    move-object/from16 v21, v13

    move-object/from16 v13, v21

    move-object/from16 v14, v21

    invoke-direct {v14}, Ljava/util/HashMap;-><init>()V

    sput-object v13, Ltrace/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    return-void

    .line 168
    :cond_0
    move-object v13, v5

    :try_start_1
    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    move-object v7, v13

    .line 170
    const-string v13, "out%d.txt"

    const/4 v14, 0x1

    new-array v14, v14, [Ljava/lang/Object;

    move-object/from16 v21, v14

    move-object/from16 v14, v21

    move-object/from16 v15, v21

    const/16 v16, 0x0

    move/from16 v17, v3

    new-instance v18, Ljava/lang/Integer;

    move/from16 v21, v17

    move-object/from16 v22, v18

    move-object/from16 v17, v22

    move/from16 v18, v21

    move-object/from16 v19, v22

    move/from16 v21, v18

    move-object/from16 v22, v19

    move-object/from16 v18, v22

    move/from16 v19, v21

    invoke-direct/range {v18 .. v19}, Ljava/lang/Integer;-><init>(I)V

    aput-object v17, v15, v16

    invoke-static {v13, v14}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v13

    move-object v8, v13

    .line 171
    move-object v13, v4

    move-object v14, v8

    invoke-virtual {v13, v14}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move-result v13

    .line 172
    new-instance v13, Ljava/io/File;

    move-object/from16 v21, v13

    move-object/from16 v13, v21

    move-object/from16 v14, v21

    new-instance v15, Ljava/lang/StringBuffer;

    move-object/from16 v21, v15

    move-object/from16 v15, v21

    move-object/from16 v16, v21

    invoke-direct/range {v16 .. v16}, Ljava/lang/StringBuffer;-><init>()V

    sget-object v16, Ltrace/MethodTrace;->cacheDir:Ljava/lang/String;

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v15

    move-object/from16 v16, v8

    invoke-virtual/range {v15 .. v16}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v15

    invoke-virtual {v15}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v15

    invoke-direct {v14, v15}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object v9, v13

    .line 173
    move-object v13, v9

    invoke-virtual {v13}, Ljava/io/File;->createNewFile()Z

    move-result v13

    .line 174
    new-instance v13, Ljava/io/FileWriter;

    move-object/from16 v21, v13

    move-object/from16 v13, v21

    move-object/from16 v14, v21

    move-object v15, v9

    invoke-direct {v14, v15}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    move-object v10, v13

    .line 175
    new-instance v13, Ljava/io/BufferedWriter;

    move-object/from16 v21, v13

    move-object/from16 v13, v21

    move-object/from16 v14, v21

    move-object v15, v10

    invoke-direct {v14, v15}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    move-object v11, v13

    .line 178
    move-object v13, v11

    move-object v14, v7

    invoke-virtual {v13, v14}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 179
    move-object v13, v11

    const-string v14, "\n"

    invoke-virtual {v13, v14}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 180
    move-object v13, v11

    const-string v14, "%s-%d_of_%d"

    const/4 v15, 0x3

    new-array v15, v15, [Ljava/lang/Object;

    move-object/from16 v21, v15

    move-object/from16 v15, v21

    move-object/from16 v16, v21

    const/16 v17, 0x0

    move-object/from16 v18, v2

    aput-object v18, v16, v17

    move-object/from16 v21, v15

    move-object/from16 v15, v21

    move-object/from16 v16, v21

    const/16 v17, 0x1

    move/from16 v18, v3

    add-int/lit8 v3, v3, 0x1

    new-instance v19, Ljava/lang/Integer;

    move/from16 v21, v18

    move-object/from16 v22, v19

    move-object/from16 v18, v22

    move/from16 v19, v21

    move-object/from16 v20, v22

    move/from16 v21, v19

    move-object/from16 v22, v20

    move-object/from16 v19, v22

    move/from16 v20, v21

    invoke-direct/range {v19 .. v20}, Ljava/lang/Integer;-><init>(I)V

    aput-object v18, v16, v17

    move-object/from16 v21, v15

    move-object/from16 v15, v21

    move-object/from16 v16, v21

    const/16 v17, 0x2

    move-object/from16 v18, v1

    invoke-virtual/range {v18 .. v18}, Ljava/util/ArrayList;->size()I

    move-result v18

    new-instance v19, Ljava/lang/Integer;

    move/from16 v21, v18

    move-object/from16 v22, v19

    move-object/from16 v18, v22

    move/from16 v19, v21

    move-object/from16 v20, v22

    move/from16 v21, v19

    move-object/from16 v22, v20

    move-object/from16 v19, v22

    move/from16 v20, v21

    invoke-direct/range {v19 .. v20}, Ljava/lang/Integer;-><init>(I)V

    aput-object v18, v16, v17

    invoke-static {v14, v15}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 183
    move-object v13, v11

    invoke-virtual {v13}, Ljava/io/BufferedWriter;->flush()V

    .line 184
    move-object v13, v11

    invoke-virtual {v13}, Ljava/io/BufferedWriter;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0

    .line 190
    :catch_0
    move-exception v13

    move-object v1, v13

    .line 195
    :try_start_2
    const-string v13, "cd %s && echo \'%s\' >> error.log"

    const/4 v14, 0x2

    new-array v14, v14, [Ljava/lang/Object;

    move-object/from16 v21, v14

    move-object/from16 v14, v21

    move-object/from16 v15, v21

    const/16 v16, 0x0

    sget-object v17, Ltrace/MethodTrace;->cacheDir:Ljava/lang/String;

    aput-object v17, v15, v16

    move-object/from16 v21, v14

    move-object/from16 v14, v21

    move-object/from16 v15, v21

    const/16 v16, 0x1

    move-object/from16 v17, v1

    invoke-virtual/range {v17 .. v17}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v17

    aput-object v17, v15, v16

    invoke-static {v13, v14}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v13

    move-object v2, v13

    .line 196
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v13

    const/4 v14, 0x3

    new-array v14, v14, [Ljava/lang/String;

    move-object/from16 v21, v14

    move-object/from16 v14, v21

    move-object/from16 v15, v21

    const/16 v16, 0x0

    const-string v17, "sh"

    aput-object v17, v15, v16

    move-object/from16 v21, v14

    move-object/from16 v14, v21

    move-object/from16 v15, v21

    const/16 v16, 0x1

    const-string v17, "-c"

    aput-object v17, v15, v16

    move-object/from16 v21, v14

    move-object/from16 v14, v21

    move-object/from16 v15, v21

    const/16 v16, 0x2

    move-object/from16 v17, v2

    aput-object v17, v15, v16

    invoke-virtual {v13, v14}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    move-result-object v13

    :goto_3
    goto/16 :goto_2

    .line 188
    :cond_1
    move-object v13, v7

    :try_start_3
    invoke-interface {v13}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    move-object v9, v13

    .line 189
    const-string v13, "cd %s && curl --data-binary @%s %s/test.php"

    const/4 v14, 0x3

    new-array v14, v14, [Ljava/lang/Object;

    move-object/from16 v21, v14

    move-object/from16 v14, v21

    move-object/from16 v15, v21

    const/16 v16, 0x0

    sget-object v17, Ltrace/MethodTrace;->cacheDir:Ljava/lang/String;

    aput-object v17, v15, v16

    move-object/from16 v21, v14

    move-object/from16 v14, v21

    move-object/from16 v15, v21

    const/16 v16, 0x1

    move-object/from16 v17, v9

    aput-object v17, v15, v16

    move-object/from16 v21, v14

    move-object/from16 v14, v21

    move-object/from16 v15, v21

    const/16 v16, 0x2

    sget-object v17, Ltrace/MethodTrace;->host:Ljava/lang/String;

    aput-object v17, v15, v16

    invoke-static {v13, v14}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v13

    move-object v10, v13

    .line 190
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v13

    const/4 v14, 0x3

    new-array v14, v14, [Ljava/lang/String;

    move-object/from16 v21, v14

    move-object/from16 v14, v21

    move-object/from16 v15, v21

    const/16 v16, 0x0

    const-string v17, "sh"

    aput-object v17, v15, v16

    move-object/from16 v21, v14

    move-object/from16 v14, v21

    move-object/from16 v15, v21

    const/16 v16, 0x1

    const-string v17, "-c"

    aput-object v17, v15, v16

    move-object/from16 v21, v14

    move-object/from16 v14, v21

    move-object/from16 v15, v21

    const/16 v16, 0x2

    move-object/from16 v17, v10

    aput-object v17, v15, v16

    invoke-virtual {v13, v14}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0

    move-result-object v13

    goto/16 :goto_1

    .line 196
    :catch_1
    move-exception v13

    move-object v2, v13

    goto :goto_3
.end method

.method private static logStep1()V
    .locals 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 92
    const-string v4, "curl \'%s/logger.php?step=%d\'"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Object;

    move-object v11, v5

    move-object v5, v11

    move-object v6, v11

    const/4 v7, 0x0

    sget-object v8, Ltrace/MethodTrace;->host:Ljava/lang/String;

    aput-object v8, v6, v7

    move-object v11, v5

    move-object v5, v11

    move-object v6, v11

    const/4 v7, 0x1

    const/4 v8, 0x1

    new-instance v9, Ljava/lang/Integer;

    move v11, v8

    move-object v12, v9

    move-object v8, v12

    move v9, v11

    move-object v10, v12

    move v11, v9

    move-object v12, v10

    move-object v9, v12

    move v10, v11

    invoke-direct {v9, v10}, Ljava/lang/Integer;-><init>(I)V

    aput-object v8, v6, v7

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    move-object v1, v4

    .line 94
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v4

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/String;

    move-object v11, v5

    move-object v5, v11

    move-object v6, v11

    const/4 v7, 0x0

    const-string v8, "sh"

    aput-object v8, v6, v7

    move-object v11, v5

    move-object v5, v11

    move-object v6, v11

    const/4 v7, 0x1

    const-string v8, "-c"

    aput-object v8, v6, v7

    move-object v11, v5

    move-object v5, v11

    move-object v6, v11

    const/4 v7, 0x2

    move-object v8, v1

    aput-object v8, v6, v7

    invoke-virtual {v4, v5}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v4

    :goto_0
    return-void

    :catch_0
    move-exception v4

    move-object v2, v4

    goto :goto_0
.end method

.method private static logStep2()V
    .locals 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 99
    const-string v4, "curl \'%s/logger.php?step=%d&lines=%d\'"

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Object;

    move-object v11, v5

    move-object v5, v11

    move-object v6, v11

    const/4 v7, 0x0

    sget-object v8, Ltrace/MethodTrace;->host:Ljava/lang/String;

    aput-object v8, v6, v7

    move-object v11, v5

    move-object v5, v11

    move-object v6, v11

    const/4 v7, 0x1

    const/4 v8, 0x2

    new-instance v9, Ljava/lang/Integer;

    move v11, v8

    move-object v12, v9

    move-object v8, v12

    move v9, v11

    move-object v10, v12

    move v11, v9

    move-object v12, v10

    move-object v9, v12

    move v10, v11

    invoke-direct {v9, v10}, Ljava/lang/Integer;-><init>(I)V

    aput-object v8, v6, v7

    move-object v11, v5

    move-object v5, v11

    move-object v6, v11

    const/4 v7, 0x2

    sget-object v8, Ltrace/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    invoke-virtual {v8}, Ljava/util/HashMap;->size()I

    move-result v8

    new-instance v9, Ljava/lang/Integer;

    move v11, v8

    move-object v12, v9

    move-object v8, v12

    move v9, v11

    move-object v10, v12

    move v11, v9

    move-object v12, v10

    move-object v9, v12

    move v10, v11

    invoke-direct {v9, v10}, Ljava/lang/Integer;-><init>(I)V

    aput-object v8, v6, v7

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    move-object v1, v4

    .line 101
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v4

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/String;

    move-object v11, v5

    move-object v5, v11

    move-object v6, v11

    const/4 v7, 0x0

    const-string v8, "sh"

    aput-object v8, v6, v7

    move-object v11, v5

    move-object v5, v11

    move-object v6, v11

    const/4 v7, 0x1

    const-string v8, "-c"

    aput-object v8, v6, v7

    move-object v11, v5

    move-object v5, v11

    move-object v6, v11

    const/4 v7, 0x2

    move-object v8, v1

    aput-object v8, v6, v7

    invoke-virtual {v4, v5}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v4

    :goto_0
    return-void

    :catch_0
    move-exception v4

    move-object v2, v4

    goto :goto_0
.end method

.method private static logStep3()V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    return-void
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
    .line 88
    move-object v0, p0

    move-object v3, v0

    sput-object v3, Ltrace/MethodTrace;->ctx:Landroid/content/Context;

    return-void
.end method

.method public static updateOnPause()V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 111
    new-instance v3, Ljava/lang/Throwable;

    move-object v5, v3

    move-object v3, v5

    move-object v4, v5

    invoke-direct {v4}, Ljava/lang/Throwable;-><init>()V

    invoke-virtual {v3}, Ljava/lang/Throwable;->fillInStackTrace()Ljava/lang/Throwable;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v3

    const/4 v4, 0x1

    aget-object v3, v3, v4

    move-object v1, v3

    .line 112
    move-object v3, v1

    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v3

    sput-object v3, Ltrace/MethodTrace;->lastTraceActivity:Ljava/lang/String;

    .line 113
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sput-wide v3, Ltrace/MethodTrace;->lastOnPause:J

    return-void
.end method

.method public static updateOnResume()V
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .prologue
    .line 118
    new-instance v3, Ljava/lang/Throwable;

    move-object v7, v3

    move-object v3, v7

    move-object v4, v7

    invoke-direct {v4}, Ljava/lang/Throwable;-><init>()V

    invoke-virtual {v3}, Ljava/lang/Throwable;->fillInStackTrace()Ljava/lang/Throwable;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v3

    const/4 v4, 0x1

    aget-object v3, v3, v4

    move-object v1, v3

    .line 121
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sget-wide v5, Ltrace/MethodTrace;->lastOnPause:J

    sub-long/2addr v3, v5

    const/16 v5, 0x7d0

    int-to-long v5, v5

    cmp-long v3, v3, v5

    if-gez v3, :cond_1

    move-object v3, v1

    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v3

    sget-object v4, Ltrace/MethodTrace;->lastTraceActivity:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 122
    sget-boolean v3, Ltrace/MethodTrace;->recordEnabled:Z

    if-eqz v3, :cond_3

    .line 124
    invoke-static {}, Ltrace/MethodTrace;->logStep2()V

    .line 125
    sget-object v3, Ltrace/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    invoke-virtual {v3}, Ljava/util/HashMap;->isEmpty()Z

    move-result v3

    if-nez v3, :cond_0

    .line 126
    invoke-static {}, Ltrace/MethodTrace;->dump()V

    .line 128
    :cond_0
    const/4 v3, 0x0

    sput-boolean v3, Ltrace/MethodTrace;->recordEnabled:Z

    .line 137
    :cond_1
    :goto_0
    sget-wide v3, Ltrace/MethodTrace;->lastOnPause:J

    const/4 v5, 0x0

    int-to-long v5, v5

    cmp-long v3, v3, v5

    if-nez v3, :cond_2

    .line 138
    invoke-static {}, Ltrace/MethodTrace;->logStep1()V

    :cond_2
    return-void

    .line 131
    :cond_3
    const/4 v3, 0x1

    sput-boolean v3, Ltrace/MethodTrace;->recordEnabled:Z

    .line 132
    invoke-static {}, Ltrace/MethodTrace;->logStep1()V

    goto :goto_0
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
    .line 230
    move-object/from16 v0, p0

    move-object v6, v0

    if-eqz v6, :cond_0

    sget-boolean v6, Ltrace/MethodTrace;->recordEnabled:Z

    if-eqz v6, :cond_0

    .line 231
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

    .line 232
    move-object v6, v0

    invoke-interface {v6}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v6

    move-object v3, v6

    .line 233
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

    sget v13, Ltrace/MethodTrace;->dataLimitLength:I

    invoke-static {v12, v13}, Ljava/lang/Math;->min(II)I

    move-result v12

    invoke-virtual {v10, v11, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    move-object v4, v6

    .line 234
    sget-object v6, Ltrace/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    move-object v7, v4

    invoke-virtual {v6, v7}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_0

    .line 235
    sget-object v6, Ltrace/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

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

    .line 236
    sget-object v6, Ltrace/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    const-string v7, "\n"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 237
    sget-object v6, Ltrace/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    move-object v7, v4

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    :cond_0
    return-void
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
    .line 204
    move-object v0, p0

    move-object v5, v0

    if-eqz v5, :cond_0

    sget-boolean v5, Ltrace/MethodTrace;->recordEnabled:Z

    if-eqz v5, :cond_0

    .line 205
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

    .line 206
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

    .line 207
    sget-object v5, Ltrace/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    move-object v6, v3

    invoke-virtual {v5, v6}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_0

    .line 208
    sget-object v5, Ltrace/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

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

    .line 209
    sget-object v5, Ltrace/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    move-object v6, v3

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    .line 210
    sget-object v5, Ltrace/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    const-string v6, "\n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    :cond_0
    return-void
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
    .line 217
    move-object/from16 v0, p0

    move-object v6, v0

    if-eqz v6, :cond_0

    sget-boolean v6, Ltrace/MethodTrace;->recordEnabled:Z

    if-eqz v6, :cond_0

    .line 218
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

    .line 219
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

    .line 220
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

    sget v13, Ltrace/MethodTrace;->dataLimitLength:I

    invoke-static {v12, v13}, Ljava/lang/Math;->min(II)I

    move-result v12

    invoke-virtual {v10, v11, v12}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    move-object v4, v6

    .line 221
    sget-object v6, Ltrace/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

    move-object v7, v4

    invoke-virtual {v6, v7}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v6

    if-nez v6, :cond_0

    .line 222
    sget-object v6, Ltrace/MethodTrace;->runtimeDataMap:Ljava/util/HashMap;

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

    .line 223
    sget-object v6, Ltrace/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    const-string v7, "\n"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    .line 224
    sget-object v6, Ltrace/MethodTrace;->recorder:Ljava/lang/StringBuilder;

    move-object v7, v4

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    :cond_0
    return-void
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
    .line 34
    move-object/from16 v2, p0

    sget-object v19, Ltrace/MethodTrace;->dumpLock:Ljava/io/File;

    invoke-virtual/range {v19 .. v19}, Ljava/io/File;->exists()Z

    move-result v19

    if-eqz v19, :cond_0

    .line 82
    :goto_0
    return-void

    .line 38
    :cond_0
    :try_start_0
    sget-object v19, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v19

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/Lock;->lock()V

    .line 41
    sget-object v19, Ltrace/MethodTrace;->filePath:Ljava/io/File;

    invoke-virtual/range {v19 .. v19}, Ljava/io/File;->length()J

    move-result-wide v19

    const/16 v21, 0x0

    move/from16 v0, v21

    int-to-long v0, v0

    move-wide/from16 v21, v0

    cmp-long v19, v19, v21

    if-nez v19, :cond_1

    .line 42
    new-instance v19, Ljava/util/HashMap;

    move-object/from16 v30, v19

    move-object/from16 v19, v30

    move-object/from16 v20, v30

    invoke-direct/range {v20 .. v20}, Ljava/util/HashMap;-><init>()V

    sput-object v19, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    .line 43
    new-instance v19, Ljava/util/ArrayList;

    move-object/from16 v30, v19

    move-object/from16 v19, v30

    move-object/from16 v20, v30

    invoke-direct/range {v20 .. v20}, Ljava/util/ArrayList;-><init>()V

    sput-object v19, Ltrace/MethodTrace;->methods:Ljava/util/ArrayList;

    .line 46
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

    .line 47
    move-object/from16 v19, v8

    const/16 v20, 0x0

    aget-object v19, v19, v20

    check-cast v19, Ljava/lang/Long;

    invoke-virtual/range {v19 .. v19}, Ljava/lang/Long;->longValue()J

    move-result-wide v19

    move-wide/from16 v9, v19

    .line 48
    move-object/from16 v19, v8

    const/16 v20, 0x1

    aget-object v19, v19, v20

    check-cast v19, Ljava/lang/Long;

    invoke-virtual/range {v19 .. v19}, Ljava/lang/Long;->longValue()J

    move-result-wide v19

    move-wide/from16 v11, v19

    .line 51
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

    .line 53
    :cond_2
    sget-object v19, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v20, v2

    invoke-virtual/range {v19 .. v20}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v19

    if-nez v19, :cond_3

    .line 54
    sget-object v19, Ltrace/MethodTrace;->methods:Ljava/util/ArrayList;

    move-object/from16 v20, v2

    invoke-virtual/range {v19 .. v20}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move-result v19

    .line 56
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

    .line 60
    :try_start_1
    new-instance v19, Ljava/io/FileWriter;

    move-object/from16 v30, v19

    move-object/from16 v19, v30

    move-object/from16 v20, v30

    sget-object v21, Ltrace/MethodTrace;->filePath:Ljava/io/File;

    invoke-direct/range {v20 .. v21}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    move-object/from16 v13, v19

    .line 61
    new-instance v19, Ljava/io/BufferedWriter;

    move-object/from16 v30, v19

    move-object/from16 v19, v30

    move-object/from16 v20, v30

    move-object/from16 v21, v13

    invoke-direct/range {v20 .. v21}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    move-object/from16 v14, v19

    .line 64
    sget-object v19, Ltrace/MethodTrace;->methods:Ljava/util/ArrayList;

    check-cast v19, Ljava/util/Collection;

    invoke-interface/range {v19 .. v19}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v19

    move-object/from16 v15, v19

    .line 66
    :goto_2
    move-object/from16 v19, v15

    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->hasNext()Z

    move-result v19

    if-nez v19, :cond_5

    .line 70
    move-object/from16 v19, v14

    invoke-virtual/range {v19 .. v19}, Ljava/io/BufferedWriter;->flush()V

    .line 71
    move-object/from16 v19, v14

    invoke-virtual/range {v19 .. v19}, Ljava/io/BufferedWriter;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 82
    :goto_3
    sget-object v19, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v19

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/Lock;->unlock()V

    goto/16 :goto_0

    .line 46
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

    .line 77
    :catch_0
    move-exception v19

    move-object/from16 v8, v19

    .line 80
    move-object/from16 v19, v8

    :try_start_3
    invoke-virtual/range {v19 .. v19}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_3

    .line 64
    :cond_5
    move-object/from16 v19, v15

    :try_start_4
    invoke-interface/range {v19 .. v19}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v19

    check-cast v19, Ljava/lang/String;

    move-object/from16 v17, v19

    .line 65
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

    .line 66
    move-object/from16 v19, v14

    invoke-virtual/range {v19 .. v19}, Ljava/io/BufferedWriter;->newLine()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto/16 :goto_2

    .line 71
    :catch_1
    move-exception v19

    move-object/from16 v13, v19

    .line 73
    move-object/from16 v19, v13

    :try_start_5
    invoke-virtual/range {v19 .. v19}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_3

    .line 77
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

    .line 80
    :catchall_0
    move-exception v19

    move-object/from16 v4, v19

    .line 82
    sget-object v19, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v19

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/Lock;->unlock()V

    move-object/from16 v19, v4

    throw v19
.end method