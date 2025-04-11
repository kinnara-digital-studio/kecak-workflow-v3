package org.kecak.apps.form.model;

import com.kinnarastudio.commons.Try;
import com.kinnarastudio.commons.jsonstream.JSONStream;
import org.joget.apps.app.service.AppUtil;
import org.joget.apps.form.model.Element;
import org.joget.apps.form.model.FormData;
import org.joget.apps.form.model.FormRowSet;
import org.joget.apps.form.service.FormUtil;
import org.json.JSONArray;
import org.json.JSONException;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import java.util.Arrays;
import java.util.Collection;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Handler for DataJsonController, this interface will be called
 * when DataJsonController assigns values to {@link FormData#addRequestParameterValues(String, String[])}
 *
 * Implement in {@link Element}. How the element will handle json data
 */
public interface DataJsonControllerHandler {
    String PARAMETER_OPTIMIZE_READONLY_ELEMENTS = "_OPTIMIZE_READONLY_ELEMENTS";
    String PARAMETER_DATA_JSON_CONTROLLER = "_DATA_JSON_CONTROLLER";
    String PARAMETER_AS_OPTIONS = "_AS_OPTIONS";

    /**
     *
     * @param values
     * @param element
     * @param formData
     * @return data that will be passed to request parameter
     */
    default String[] handleMultipartDataRequest(@Nonnull String[] values, @Nonnull Element element, @Nonnull FormData formData) {
        return Arrays.stream(values)
                .map(s -> AppUtil.processHashVariable(s, formData.getAssignment(), null, null))
                .toArray(String[]::new);
    }

    /**
     *
     * @param value can be one of JSONObject, JSONArray, String or primitives
     * @param element
     * @param formData
     * @return data that will be passed to request parameter
     */
    default String[] handleJsonDataRequest(@Nullable Object value, @Nonnull Element element, @Nonnull FormData formData) throws JSONException {
        if(value == null) {
            return new String[0];
        }

        if (value instanceof Double) {
            return new String[]{String.format("%f", value).replaceAll("(?<!\\.)0+$", "")};
        } else if(value instanceof JSONArray) {
            return JSONStream.of((JSONArray) value, Try.onBiFunction(JSONArray::getString))
                    .filter(s -> !s.isEmpty())
                    .toArray(String[]::new);
        } else {
            return new String[]{AppUtil.processHashVariable(String.valueOf(value), formData.getAssignment(), null, null)};
        }
    }

    /**
     * Handle values that will be thrown as response in DataJsonController
     *
     * @param element
     * @param formData
     * @value that will be shown as response
     */
    default Object handleElementValueResponse(@Nonnull Element element, @Nonnull FormData formData) throws JSONException {
        final String elementId = element.getPropertyString("id");
        return Optional.of(element)
                .map(formData::getLoadBinderData)
                .map(FormRowSet::stream)
                .orElseGet(Stream::empty)
                .map(r -> r.getProperty(elementId))
                .map(String::valueOf)
                .collect(Collectors.joining(";"));
    }
}
