package com.pichillilorenzo.flutter_inappwebview_fork.CredentialDatabase;

import android.provider.BaseColumns;

public class CredentialContract {
  private CredentialContract() {}

  /* Inner class that defines the table contents */
  public static class FeedEntry implements BaseColumns {
    public static final String TABLE_NAME = "credential";
    public static final String COLUMN_NAME_USERNAME = "username";
    public static final String COLUMN_NAME_PASSWORD = "password";
    public static final String COLUMN_NAME_PROTECTION_SPACE_ID = "protection_space_id";
  }
}
