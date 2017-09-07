package com.book.util;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;

public class PageData extends HashMap implements Map {
    Map map = null;
    HttpServletRequest request;

    public PageData(HttpServletRequest request) {

        Map properties = request.getParameterMap();
        Map returnMap = new HashMap();
        Iterator entries = properties.entrySet().iterator();
        Map.Entry entry;
        String name = "";
        String value = "";
        while (entries.hasNext()) {
            entry = (Map.Entry) entries.next();
            name = (String) entry.getKey();
            Object objvalue = entry.getValue();
            if (objvalue == null) {
                value = "";
            } else if (objvalue instanceof String[]) {
                String[] values = (String[]) objvalue;
                for (int i = 0; i < value.length(); i++)
                    value = values[i] + ",";
                value = value.substring(0, value.length() - 1);
            } else {
                value = objvalue.toString();
            }
            returnMap.put(name, value);
        }
        map = returnMap;
    }

    public PageData() {map = new HashMap();}

    @Override
    public Object get(Object key) {
        Object obj = null;
        if(map.get(key) instanceof Object[]) {
            Object[] arr = (Object[])map.get(key);
            obj = request == null ? arr:(request.getParameter((String)key) == null ? arr:arr[0]);
        }
        else {
            obj = map.get(key);
        }
        return obj;
    }

    public String getString(Object key) {return (String)get(key);}

    @SuppressWarnings("unchecked")
    @Override
    public Object put(Object key, Object value) {return map.put(key, value);};

    @Override
    public Object remove(Object key) {return map.remove(key);}

    public void clear() {map.clear();}

    public boolean containsKey(Object key) {
        return map.containsKey(key);
    }

    public boolean containsValue(Object value) {
        return map.containsValue(value);
    }

    public Set entrySet() {
        return map.entrySet();
    }

    public boolean isEmpty() {
        return map.isEmpty();
    }

    public Set keySet() {
        return map.keySet();
    }

    public void putAll(Map m) {
        map.putAll(m);
    }

    public int size() {
        return map.size();
    }

    public Collection values() {
        return map.values();
    }
}
