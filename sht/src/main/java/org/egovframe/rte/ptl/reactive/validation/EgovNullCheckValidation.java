package org.egovframe.rte.ptl.reactive.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class EgovNullCheckValidation implements ConstraintValidator<EgovNullCheck, Object> {
    @Override
    public void initialize(EgovNullCheck constraintAnnotation) {
        // 초기화 필요시 구현
    }

    @Override
    public boolean isValid(Object value, ConstraintValidatorContext context) {
        // null 또는 빈 문자열 체크
        if (value == null)
            return false;
        if (value instanceof String) {
            return !((String) value).trim().isEmpty();
        }
        return true;
    }
}
