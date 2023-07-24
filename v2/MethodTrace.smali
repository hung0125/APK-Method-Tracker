.class public Ltrace/MethodTrace;
.super Ljava/lang/Object;
.source "MethodTrace.java"


# static fields
.field private static final fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

.field private static methodMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
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


# direct methods
.method static final constructor <clinit>()V
    .locals 5

    new-instance v2, Ljava/util/concurrent/locks/ReentrantReadWriteLock;

    move-object v4, v2

    move-object v2, v4

    move-object v3, v4

    invoke-direct {v3}, Ljava/util/concurrent/locks/ReentrantReadWriteLock;-><init>()V

    sput-object v2, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    new-instance v2, Ljava/util/HashMap;

    move-object v4, v2

    move-object v2, v4

    move-object v3, v4

    invoke-direct {v3}, Ljava/util/HashMap;-><init>()V

    sput-object v2, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    new-instance v2, Ljava/util/ArrayList;

    move-object v4, v2

    move-object v2, v4

    move-object v3, v4

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    sput-object v2, Ltrace/MethodTrace;->methods:Ljava/util/ArrayList;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    .line 58
    move-object v0, p0

    move-object v2, v0

    invoke-direct {v2}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static writeTrace(Ljava/lang/String;)V
    .locals 29
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 15
    move-object/from16 v2, p0

    :try_start_0
    sget-object v20, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface/range {v20 .. v20}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v20

    invoke-interface/range {v20 .. v20}, Ljava/util/concurrent/locks/Lock;->lock()V

    .line 17
    sget-object v20, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v21, v2

    invoke-virtual/range {v20 .. v21}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v20

    if-eqz v20, :cond_2

    sget-object v20, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v21, v2

    invoke-virtual/range {v20 .. v21}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v20

    check-cast v20, Ljava/lang/String;

    const-string v21, " "

    invoke-virtual/range {v20 .. v21}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v20

    :goto_0
    move-object/from16 v8, v20

    .line 18
    move-object/from16 v20, v8

    const/16 v21, 0x0

    aget-object v20, v20, v21

    invoke-static/range {v20 .. v20}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v20

    move-wide/from16 v9, v20

    .line 19
    move-object/from16 v20, v8

    const/16 v21, 0x1

    aget-object v20, v20, v21

    invoke-static/range {v20 .. v20}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v20

    move-wide/from16 v11, v20

    .line 22
    sget-object v20, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v21, v2

    invoke-virtual/range {v20 .. v21}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v20

    if-eqz v20, :cond_0

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v20

    move-wide/from16 v22, v9

    sub-long v20, v20, v22

    const-wide/32 v22, 0x1dcd6500

    cmp-long v20, v20, v22

    if-lez v20, :cond_4

    .line 24
    :cond_0
    new-instance v20, Ljava/io/File;

    move-object/from16 v28, v20

    move-object/from16 v20, v28

    move-object/from16 v21, v28

    const-string v22, "/sdcard/trace/trace.txt"

    invoke-direct/range {v21 .. v22}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    move-object/from16 v13, v20

    .line 27
    sget-object v20, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v21, v2

    invoke-virtual/range {v20 .. v21}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v20

    if-nez v20, :cond_1

    .line 28
    sget-object v20, Ltrace/MethodTrace;->methods:Ljava/util/ArrayList;

    move-object/from16 v21, v2

    invoke-virtual/range {v20 .. v21}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move-result v20

    .line 30
    :cond_1
    sget-object v20, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v21, v2

    new-instance v22, Ljava/lang/StringBuffer;

    move-object/from16 v28, v22

    move-object/from16 v22, v28

    move-object/from16 v23, v28

    invoke-direct/range {v23 .. v23}, Ljava/lang/StringBuffer;-><init>()V

    new-instance v23, Ljava/lang/StringBuffer;

    move-object/from16 v28, v23

    move-object/from16 v23, v28

    move-object/from16 v24, v28

    invoke-direct/range {v24 .. v24}, Ljava/lang/StringBuffer;-><init>()V

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v24

    invoke-static/range {v24 .. v25}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v24

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v23

    const-string v24, " "

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v23

    invoke-virtual/range {v23 .. v23}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v23

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v22

    move-wide/from16 v23, v11

    const/16 v25, 0x1

    move/from16 v0, v25

    int-to-long v0, v0

    move-wide/from16 v25, v0

    add-long v23, v23, v25

    invoke-static/range {v23 .. v24}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v23

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v20 .. v22}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result-object v20

    .line 34
    :try_start_1
    new-instance v20, Ljava/io/FileWriter;

    move-object/from16 v28, v20

    move-object/from16 v20, v28

    move-object/from16 v21, v28

    move-object/from16 v22, v13

    invoke-direct/range {v21 .. v22}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    move-object/from16 v14, v20

    .line 35
    new-instance v20, Ljava/io/BufferedWriter;

    move-object/from16 v28, v20

    move-object/from16 v20, v28

    move-object/from16 v21, v28

    move-object/from16 v22, v14

    invoke-direct/range {v21 .. v22}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    move-object/from16 v15, v20

    .line 38
    sget-object v20, Ltrace/MethodTrace;->methods:Ljava/util/ArrayList;

    check-cast v20, Ljava/util/Collection;

    invoke-interface/range {v20 .. v20}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v20

    move-object/from16 v16, v20

    .line 40
    :goto_1
    move-object/from16 v20, v16

    invoke-interface/range {v20 .. v20}, Ljava/util/Iterator;->hasNext()Z

    move-result v20

    if-nez v20, :cond_3

    .line 44
    move-object/from16 v20, v15

    invoke-virtual/range {v20 .. v20}, Ljava/io/BufferedWriter;->flush()V

    .line 45
    move-object/from16 v20, v15

    invoke-virtual/range {v20 .. v20}, Ljava/io/BufferedWriter;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 56
    :goto_2
    sget-object v20, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface/range {v20 .. v20}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v20

    invoke-interface/range {v20 .. v20}, Ljava/util/concurrent/locks/Lock;->unlock()V

    return-void

    .line 17
    :cond_2
    const/16 v20, 0x2

    :try_start_2
    move/from16 v0, v20

    new-array v0, v0, [Ljava/lang/String;

    move-object/from16 v20, v0

    move-object/from16 v28, v20

    move-object/from16 v20, v28

    move-object/from16 v21, v28

    const/16 v22, 0x0

    const-string v23, "0"

    aput-object v23, v21, v22

    move-object/from16 v28, v20

    move-object/from16 v20, v28

    move-object/from16 v21, v28

    const/16 v22, 0x1

    const-string v23, "0"

    aput-object v23, v21, v22
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    goto/16 :goto_0

    .line 51
    :catch_0
    move-exception v20

    move-object/from16 v8, v20

    .line 54
    move-object/from16 v20, v8

    :try_start_3
    invoke-virtual/range {v20 .. v20}, Ljava/lang/Exception;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    goto :goto_2

    .line 38
    :cond_3
    move-object/from16 v20, v16

    :try_start_4
    invoke-interface/range {v20 .. v20}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v20

    check-cast v20, Ljava/lang/String;

    move-object/from16 v18, v20

    .line 39
    move-object/from16 v20, v15

    new-instance v21, Ljava/lang/StringBuffer;

    move-object/from16 v28, v21

    move-object/from16 v21, v28

    move-object/from16 v22, v28

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuffer;-><init>()V

    new-instance v22, Ljava/lang/StringBuffer;

    move-object/from16 v28, v22

    move-object/from16 v22, v28

    move-object/from16 v23, v28

    invoke-direct/range {v23 .. v23}, Ljava/lang/StringBuffer;-><init>()V

    move-object/from16 v23, v18

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v22

    const-string v23, " "

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v21

    sget-object v22, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v23, v18

    invoke-virtual/range {v22 .. v23}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v22

    check-cast v22, Ljava/lang/String;

    invoke-static/range {v22 .. v22}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v21 .. v22}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v21

    invoke-virtual/range {v21 .. v21}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v21

    invoke-virtual/range {v20 .. v21}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 40
    move-object/from16 v20, v15

    invoke-virtual/range {v20 .. v20}, Ljava/io/BufferedWriter;->newLine()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    goto/16 :goto_1

    .line 45
    :catch_1
    move-exception v20

    move-object/from16 v14, v20

    .line 47
    move-object/from16 v20, v14

    :try_start_5
    invoke-virtual/range {v20 .. v20}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_2

    .line 51
    :cond_4
    sget-object v20, Ltrace/MethodTrace;->methodMap:Ljava/util/HashMap;

    move-object/from16 v21, v2

    new-instance v22, Ljava/lang/StringBuffer;

    move-object/from16 v28, v22

    move-object/from16 v22, v28

    move-object/from16 v23, v28

    invoke-direct/range {v23 .. v23}, Ljava/lang/StringBuffer;-><init>()V

    new-instance v23, Ljava/lang/StringBuffer;

    move-object/from16 v28, v23

    move-object/from16 v23, v28

    move-object/from16 v24, v28

    invoke-direct/range {v24 .. v24}, Ljava/lang/StringBuffer;-><init>()V

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v24

    invoke-static/range {v24 .. v25}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v24

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v23

    const-string v24, " "

    invoke-virtual/range {v23 .. v24}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v23

    invoke-virtual/range {v23 .. v23}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v23

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v22

    move-wide/from16 v23, v11

    const/16 v25, 0x1

    move/from16 v0, v25

    int-to-long v0, v0

    move-wide/from16 v25, v0

    add-long v23, v23, v25

    invoke-static/range {v23 .. v24}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v23

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v22

    invoke-virtual/range {v20 .. v22}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    move-result-object v20

    goto/16 :goto_2

    .line 54
    :catchall_0
    move-exception v20

    move-object/from16 v4, v20

    .line 56
    sget-object v20, Ltrace/MethodTrace;->fileLock:Ljava/util/concurrent/locks/ReadWriteLock;

    invoke-interface/range {v20 .. v20}, Ljava/util/concurrent/locks/ReadWriteLock;->writeLock()Ljava/util/concurrent/locks/Lock;

    move-result-object v20

    invoke-interface/range {v20 .. v20}, Ljava/util/concurrent/locks/Lock;->unlock()V

    move-object/from16 v20, v4

    throw v20
.end method
