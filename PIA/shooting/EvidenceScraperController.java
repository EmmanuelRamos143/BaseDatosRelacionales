package com.sullexis.text.tools.shooting;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/evidence/")
public class EvidenceScraperController {


    @Autowired
    private EvidenceScrapedRepo evidenceScrapedRepo;

    @Autowired
    private OfficerRepo officerRepo;

    @RequestMapping(value = "insertEvidenceScraped", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    public EvidenceScraped updateAliasTargetAttribute(@RequestBody EvidenceScraped evidenceScraped) {
        return evidenceScrapedRepo.save(evidenceScraped);
    }

    @RequestMapping(value = "officers", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Officer> getOfficers() {
        return officerRepo.findAll();
    }

    @RequestMapping(value = "officer/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public Officer getOfficer(@PathVariable(name = "id") String oid) {
        ObjectId objId = new ObjectId(oid);
        return officerRepo.findById(objId).orElse(new Officer());
    }
    
}
