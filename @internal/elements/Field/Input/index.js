import React from "react";
import {mapValues} from "@unction/complete";

export default function Input (properties) {
  const {type, labelId, descriptionId, id, options, multiple, rows, selected, inputSizeClassName = "", inputClassName = "", ...remainingProperties} = properties;

  if (type === "range") {
    return <input className={`${inputSizeClassName} ${inputClassName} form-control-range custom-range`} id={id} name={name} aria-labelledby={labelId} aria-describedby={descriptionId} type={type} {...remainingProperties} />;
  }

  if (type === "file") {
    return <input className={`${inputSizeClassName} ${inputClassName} form-control-file custom-file-input`} id={id} name={name} aria-labelledby={labelId} aria-describedby={descriptionId} type={type} {...remainingProperties} />;
  }

  if (type === "textarea") {
    return <textarea className={`${inputSizeClassName} ${inputClassName} form-control`} id={id} name={name} aria-labelledby={labelId} aria-describedby={descriptionId} rows={rows} {...remainingProperties} />;
  }

  if (type === "select") {
    return <select className={`${inputSizeClassName} ${inputClassName} form-control custom-select`} id={id} name={name} aria-labelledby={labelId} aria-describedby={descriptionId} multiple={multiple} {...remainingProperties}>
      {mapValues(({key, value}) => <option value={value} selected={selected === key}>{key}</option>)(options)}
    </select>;
  }

  if (type === "radio" || type === "checkbox") {
    return <input className={`${inputSizeClassName} ${inputClassName} form-check-input`} id={id} name={name} aria-labelledby={labelId} aria-describedby={descriptionId} type={type} {...remainingProperties} />;
  }

  return <input className={`${inputSizeClassName} ${inputClassName} form-control`} id={id} name={name} aria-labelledby={labelId} aria-describedby={descriptionId} type={type} {...remainingProperties} />;
}
