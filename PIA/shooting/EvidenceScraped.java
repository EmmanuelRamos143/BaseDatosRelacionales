package com.sullexis.text.tools.shooting;

import lombok.Data;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.core.mapping.Document;

import javax.persistence.Id;
import java.util.Date;

@Data
@Document("EvidenceScraped")
public class EvidenceScraped {

    @Id
    private ObjectId _id;
    private String rawNewScrapped;
    private String officerName;
    private String victimName;
    private String theartLevel;
    private String urlEvidence;
    private String state;
    private String location;
    private String race;
    private Date dateEvent;
    private String caseNumber;
}
