package com.ruoyi.common;

import lombok.Data;

@Data
public class R<T> {
    private  Integer code;
    private  T data;
    private  String msg;
    public  static  <T> R<T> success(T t){
        R<T> tr = new R<>();
        tr.setCode(200);
        tr.setData(t);
        tr.setMsg("操作成功");
        return  tr;
    }
    public  static  <T> R<T> error(String msg){
        R<T> tr = new R<>();
        tr.setCode(500);
        tr.setData(null);
        tr.setMsg(msg);
        return  tr;
    }
}
