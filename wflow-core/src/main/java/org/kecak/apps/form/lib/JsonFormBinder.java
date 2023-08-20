package org.joget.apps.form.lib;

import com.kinnarastudio.commons.Declutter;
import org.joget.apps.form.model.*;

public class JsonFormBinder extends FormBinder
        implements FormLoadElementBinder, FormStoreElementBinder, Declutter {
    @Override
    public FormRowSet load(Element element, String primaryKey, FormData formData) {
        return null;
    }

    @Override
    public FormRowSet store(Element element, FormRowSet rows, FormData formData) {
        return null;
    }

    @Override
    public String getName() {
        return null;
    }

    @Override
    public String getVersion() {
        return null;
    }

    @Override
    public String getDescription() {
        return null;
    }

    @Override
    public String getLabel() {
        return null;
    }

    @Override
    public String getClassName() {
        return null;
    }

    @Override
    public String getPropertyOptions() {
        return null;
    }
}
