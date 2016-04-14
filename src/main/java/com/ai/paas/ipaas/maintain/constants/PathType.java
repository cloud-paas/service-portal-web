package com.ai.paas.ipaas.maintain.constants;

/**
 * Created by astraea on 2015/5/4.
 */
public enum PathType {
    READONLY(1, "readOnly path"), WRITABLE(2, "writable path");

    private String description;
    private int flag;

    PathType(int flag, String description) {
        this.flag = flag;
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public static PathType convertPathType(int flag) {
        switch (flag) {
            case 1:
                return PathType.READONLY;
            case 2:
                return PathType.WRITABLE;
            default:
                throw new RuntimeException("");
        }
    }
}
