with location as (

    select
        location_iso_code as id,
        location,
        island,
        AREA_KM_2_ as area

    from "INTERVIEW_DB"."PLAYGROUND_SURIYA_BALAMURUGAN"."LOCATION"

),

deathrate as (

    select
        location_iso_code as id,
        date,
        total_cases,
        total_active_cases,
        total_deaths,
        case_fatality_rate

    from "INTERVIEW_DB"."PLAYGROUND_SURIYA_BALAMURUGAN"."COVID_INFO"

),

populate as (

    select
        id,
        min(case_fatality_rate) as lower_rate,
        max(case_fatality_rate) as higher_rate

    from deathrate
    group by 1

),


final as (

    select
        location.id,
        location.location,
        location.island,
        populate.lower_rate,
        populate.higher_rate

    from location
    join populate using (id)

)

select * from final
