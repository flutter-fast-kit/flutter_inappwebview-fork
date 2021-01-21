package com.pichillilorenzo.flutter_inappwebview_fork.ContentBlocker;

public class ContentBlocker {
    public ContentBlockerTrigger trigger;
    public ContentBlockerAction action;

    public ContentBlocker (ContentBlockerTrigger trigger, ContentBlockerAction action) {
        this.trigger = trigger;
        this.action = action;
    }
}
