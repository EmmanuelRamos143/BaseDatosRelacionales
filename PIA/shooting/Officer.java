package com.sullexis.text.tools.shooting;

import lombok.Data;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Id;
import java.util.List;

@Data
@Document("Officer")
public class Officer {

    @Id
    private ObjectId _id;
    private String name;
    private boolean offDutty;
    private List<String> badBehavior;
    private List<String> decorated;
}
