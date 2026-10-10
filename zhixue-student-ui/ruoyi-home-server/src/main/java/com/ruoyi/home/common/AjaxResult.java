package com.ruoyi.home.common;

import java.util.HashMap;

public class AjaxResult extends HashMap<String, Object> {

    private static final String CODE = "code";
    private static final String MSG = "msg";
    private static final String DATA = "data";

    public AjaxResult() {
    }

    public AjaxResult(int code, String msg, Object data) {
        super.put(CODE, code);
        super.put(MSG, msg);
        if (data != null) {
            super.put(DATA, data);
        }
    }

    public static AjaxResult success() {
        return success("操作成功");
    }

    public static AjaxResult success(Object data) {
        return success("操作成功", data);
    }

    public static AjaxResult success(String msg, Object data) {
        return new AjaxResult(200, msg, data);
    }

    public static AjaxResult error(String msg) {
        return new AjaxResult(500, msg, null);
    }
}
