package com.ai.paas.ipaas.maintain.constants;

import java.io.Serializable;

@SuppressWarnings("serial")
public class CCSComponentOperationParam implements Serializable {
    private String userId;

    private String path;

    private Object data;

    public PathType getPathType() {
        return pathType;
    }

    public void setPathType(PathType pathType) {
        this.pathType = pathType;
    }

    private PathType pathType;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "CCSComponentOperationParam{" +
                "userId='" + userId + '\'' +
                ", path='" + path + '\'' +
                ", data=" + data +
                ", pathType=" + pathType +
                '}';
    }
}
