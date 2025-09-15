package org.joget.workflow.model.service;

import org.enhydra.shark.api.client.wfmc.wapi.WMConnectInfo;
import org.enhydra.shark.api.client.wfmc.wapi.WMSessionHandle;
import org.enhydra.shark.api.client.wfmodel.*;
import org.enhydra.shark.api.client.wfservice.SharkConnection;
import org.enhydra.shark.api.client.wfservice.WfProcessMgrIterator;
import org.enhydra.shark.api.client.wfservice.WfResourceIterator;

public class ClosableSharkConnection implements SharkConnection, AutoCloseable {
    private final SharkConnection sharkConnection;

    public ClosableSharkConnection(SharkConnection sharkConnection) {
        this.sharkConnection = sharkConnection;
    }

    @Override
    public void close() throws Exception {
        try {
            if(sharkConnection != null)
                sharkConnection.disconnect();
        } catch (Exception e) {
            // ignore
        }
    }

    @Override
    public void connect(WMConnectInfo wmConnectInfo) throws Exception {
        sharkConnection.connect(wmConnectInfo);
    }

    @Override
    public void attachToHandle(WMSessionHandle wmSessionHandle) throws Exception {
        sharkConnection.attachToHandle(wmSessionHandle);
    }

    @Override
    public void disconnect() throws Exception {
        if(sharkConnection != null)
            sharkConnection.disconnect();
    }

    @Override
    public WMSessionHandle getSessionHandle() throws Exception {
        return sharkConnection.getSessionHandle();
    }

    @Override
    public WfResource getResourceObject() throws Exception {
        return sharkConnection.getResourceObject();
    }

    @Override
    public WfProcessMgrIterator get_iterator_processmgr() throws Exception {
        return sharkConnection.get_iterator_processmgr();
    }

    @Override
    public WfProcessMgr[] get_sequence_processmgr(int i) throws Exception {
        return sharkConnection.get_sequence_processmgr(i);
    }

    @Override
    public WfResourceIterator get_iterator_resource() throws Exception {
        return sharkConnection.get_iterator_resource();
    }

    @Override
    public WfResource[] get_sequence_resource(int i) throws Exception {
        return sharkConnection.get_sequence_resource(i);
    }

    @Override
    public WfProcessMgr getProcessMgr(String s) throws Exception {
        return sharkConnection.getProcessMgr(s);
    }

    @Override
    public WfResource getResource(String s) throws Exception {
        return sharkConnection.getResource(s);
    }

    @Override
    public WfProcess getProcess(String s) throws Exception {
        return sharkConnection.getProcess(s);
    }

    @Override
    public WfActivity getActivity(String s, String s1) throws Exception {
        return sharkConnection.getActivity(s, s1);
    }

    @Override
    public WfAssignment getAssignment(String s, String s1, String s2) throws Exception {
        return sharkConnection.getAssignment(s, s1, s2);
    }

    @Override
    public WfAssignment getAssignment(String s, String s1) throws Exception {
        return sharkConnection.getAssignment(s, s1);
    }

    @Override
    public WfAssignmentIterator get_iterator_assignment() throws Exception {
        return sharkConnection.get_iterator_assignment();
    }

    @Override
    public WfProcessIterator get_iterator_process() throws Exception {
        return sharkConnection.get_iterator_process();
    }

    @Override
    public WfActivityIterator get_iterator_activity() throws Exception {
        return sharkConnection.get_iterator_activity();
    }
}
