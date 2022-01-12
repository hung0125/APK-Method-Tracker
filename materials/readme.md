1. Create a new smali classes folder under the root decompiled directory
2. Move the original android library (if any) to the new smali classes folder
3. Download the required library.zip and put the additional android library inside the new smali classes folder
4. Replace if duplicate files exist
5. Inject permission command
6. Set target sdk to 23, min sdk should be equal or lower than 23
7. Add permission <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
