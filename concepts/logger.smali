.method private static logger20220108(Ljava/lang/String;)V
    .locals 25
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 39
    move-object/from16 v0, p0

    move-object v10, v0

    const-string v11, "#"

    invoke-virtual {v10, v11}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v10

    move-object v2, v10

    .line 40
    move-object v10, v2

    const/4 v11, 0x1

    aget-object v10, v10, v11

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v10

    check-cast v10, Ljava/lang/Integer;

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v10

    move v3, v10

    .line 41
    move-object v10, v2

    const/4 v11, 0x2

    aget-object v10, v10, v11

    invoke-static {v10}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v10

    check-cast v10, Ljava/lang/Integer;

    invoke-virtual {v10}, Ljava/lang/Integer;->intValue()I

    move-result v10

    move v4, v10

    .line 42
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v10

    const-wide/16 v12, 0x3e8

    div-long/2addr v10, v12

    move-wide v5, v10

    .line 44
    sget-object v10, #classPath#;->doseq20220108:[J

    if-nez v10, :cond_0

    .line 45
    move v10, v4

    new-array v10, v10, [J

    sput-object v10, #classPath#;->doseq20220108:[J

    .line 47
    :cond_0
    sget-object v10, #classPath#;->doseq20220108:[J

    move v11, v3

    aget-wide v10, v10, v11

    const/4 v12, 0x0

    int-to-long v12, v12

    cmp-long v10, v10, v12

    if-eqz v10, :cond_1

    move-wide v10, v5

    sget-object v12, #classPath#;->doseq20220108:[J

    move v13, v3

    aget-wide v12, v12, v13

    sub-long/2addr v10, v12

    const/4 v12, 0x1

    int-to-long v12, v12

    cmp-long v10, v10, v12

    if-ltz v10, :cond_2

    .line 48
    :cond_1
    sget-object v10, #classPath#;->doseq20220108:[J

    move v11, v3

    move-wide v12, v5

    aput-wide v12, v10, v11

    .line 52
    const/4 v10, 0x3

    new-array v10, v10, [Ljava/lang/String;

    move-object/from16 v22, v10

    move-object/from16 v10, v22

    move-object/from16 v11, v22

    const/4 v12, 0x0

    const-string v13, "sh"

    aput-object v13, v11, v12

    move-object/from16 v22, v10

    move-object/from16 v10, v22

    move-object/from16 v11, v22

    const/4 v12, 0x1

    const-string v13, "-c"

    aput-object v13, v11, v12

    move-object/from16 v22, v10

    move-object/from16 v10, v22

    move-object/from16 v11, v22

    const/4 v12, 0x2

    const-string v13, "mkdir /sdcard/traceTmp & echo \'%d\' > \'/sdcard/traceTmp/%s._\'"

    const/4 v14, 0x2

    new-array v14, v14, [Ljava/lang/Object;

    move-object/from16 v22, v14

    move-object/from16 v14, v22

    move-object/from16 v15, v22

    const/16 v16, 0x0

    invoke-static {}, Ljava/lang/System;->nanoTime()J

    move-result-wide v17

    new-instance v19, Ljava/lang/Long;

    move-wide/from16 v22, v17

    move-object/from16 v24, v19

    move-object/from16 v17, v24

    move-wide/from16 v18, v22

    move-object/from16 v20, v24

    move-wide/from16 v22, v18

    move-object/from16 v24, v20

    move-object/from16 v18, v24

    move-wide/from16 v19, v22

    move-object/from16 v21, v24

    invoke-direct/range {v18 .. v20}, Ljava/lang/Long;-><init>(J)V

    aput-object v17, v15, v16

    move-object/from16 v22, v14

    move-object/from16 v14, v22

    move-object/from16 v15, v22

    const/16 v16, 0x1

    move-object/from16 v17, v2

    const/16 v18, 0x0

    aget-object v17, v17, v18

    aput-object v17, v15, v16

    invoke-static {v13, v14}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v13

    aput-object v13, v11, v12

    move-object v7, v10

    .line 55
    :try_start_0
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v10

    move-object v11, v7

    invoke-virtual {v10, v11}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v10

    :goto_0
    return-void

    .line 50
    :cond_2
    goto :goto_0

    .line 55
    :catch_0
    move-exception v10

    move-object v8, v10

    goto :goto_0
.end method
