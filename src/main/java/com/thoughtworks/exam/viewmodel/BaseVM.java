package com.thoughtworks.exam.viewmodel;

import com.thoughtworks.exam.utility.ModelMapperSingle;
import lombok.Data;
import org.modelmapper.ModelMapper;

/**
 * @author alvis
 */

@Data
public class BaseVM {
    protected static ModelMapper modelMapper = ModelMapperSingle.Instance();


}
