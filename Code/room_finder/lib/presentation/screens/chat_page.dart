import 'package:flutter/material.dart';
import 'package:room_finder/presentation/components/chat_item.dart';
import 'package:room_finder/presentation/components/screens_templates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:room_finder/presentation/screens/chat_detail_page.dart';

class StudentChatPage extends StatelessWidget {
  const StudentChatPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return StudentTemplateScreen(
      screenLabel: AppLocalizations.of(context)!.lblChatPage, 
      screenContent: Column(
          children: [
            ChatItem(
              receiverPhoto: "https://media.gettyimages.com/id/1437816897/it/foto/ritratto-di-donna-daffari-manager-o-risorse-umane-per-il-successo-professionale-azienda-che.jpg?s=1024x1024&w=gi&k=20&c=AZl4qDLGEEdWlhxzv2xe7gWW9BLYW06adV8Zm0uXOaI=", 
              facilityPhoto: "https://media.mondoconv.it/media/catalog/product/cache/9183606dc745a22d5039e6cdddceeb98/X/A/XABP_1LVL.jpg", 
              receiverName: "Giada Rossi", 
              facilityName: "Casa Dolce Casa", 
              address: "Via Roma 12", 
              lastMessage: DateTime(2024,7,1), 
              isLastChatItem: false, 
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ChatDetailPage(
                    receiverImageUrl: "https://media.gettyimages.com/id/1437816897/it/foto/ritratto-di-donna-daffari-manager-o-risorse-umane-per-il-successo-professionale-azienda-che.jpg?s=1024x1024&w=gi&k=20&c=AZl4qDLGEEdWlhxzv2xe7gWW9BLYW06adV8Zm0uXOaI=", 
                    receiverName: "Giada Rossi", 
                    facilityName: "Casa Dolce Casa", 
                    lastMessage: DateTime(2024,7,1), 
                    onTap: () => {}
                  )
                )
              )
            ),

            ChatItem(
              receiverPhoto: "https://www.fotografareperstupire.com/wp-content/uploads/2023/03/pose-per-foto-uomo-selfie.jpg", 
              facilityPhoto: "https://cdn.cosedicasa.com/wp-content/uploads/webp/2022/05/cucina-e-soggiorno-640x320.webp", 
              receiverName: "Mario Guidi", 
              facilityName: "Bella Italia", 
              address: "Via Belzoni 5", 
              lastMessage: DateTime(2024,6,28), 
              isLastChatItem: false, 
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ChatDetailPage(
                    receiverImageUrl: "https://www.fotografareperstupire.com/wp-content/uploads/2023/03/pose-per-foto-uomo-selfie.jpg", 
                    receiverName: "Mario Guidi", 
                    facilityName: "Bella Italia", 
                    lastMessage: DateTime(2024,6,28), 
                    onTap: () => {}
                  )
                )
              )
            ),

            ChatItem(
              receiverPhoto: "https://www.fotografareperstupire.com/wp-content/uploads/2023/03/pose-modello-uomo.jpg", 
              facilityPhoto: "https://www.grazia.it/content/uploads/2018/03/come-arredare-monolocale-sfruttando-centimetri-2.jpg", 
              receiverName: "Luigi Frassi", 
              facilityName: "Casa Studenti", 
              address: "Viale Luna 289", 
              lastMessage: DateTime(2024,6,25), 
              isLastChatItem: false, 
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ChatDetailPage(
                    receiverImageUrl: "https://www.fotografareperstupire.com/wp-content/uploads/2023/03/pose-modello-uomo.jpg", 
                    receiverName: "Luigi Frassi", 
                    facilityName: "Casa Studenti", 
                    lastMessage: DateTime(2024,6,25), 
                    onTap: () => {}
                  )
                )
              )
            ),

            ChatItem(
              receiverPhoto: "https://www.thewom.it/content/uploads/2022/01/Rosalind-Brewer-830x1107.jpg", 
              facilityPhoto: "https://www.fiorenzointeriordesign.com/images/galcms/850x635c50q80/galleryone/gallery-prodotto-test/zoom/img_6206_65721.jpg", 
              receiverName: "Serena Pizzoli", 
              facilityName: "Casa Studio", 
              address: "Via Vittoria 10", 
              lastMessage: DateTime(2024,6,20), 
              isLastChatItem: true, 
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ChatDetailPage(
                    receiverImageUrl: "https://www.thewom.it/content/uploads/2022/01/Rosalind-Brewer-830x1107.jpg", 
                    receiverName: "Serena Pizzoli", 
                    facilityName: "Casa Studio", 
                    lastMessage: DateTime(2024,6,20), 
                    onTap: () => {}
                  )
                )
              )
            )
          ]
        )
    );
  }
}

class HostChatPage extends StatelessWidget {
  const HostChatPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return StudentTemplateScreen(
      screenLabel: AppLocalizations.of(context)!.lblChatPage, 
      screenContent: Column(
          children: [
            ChatItem(
              receiverPhoto: "https://media.gettyimages.com/id/1437816897/it/foto/ritratto-di-donna-daffari-manager-o-risorse-umane-per-il-successo-professionale-azienda-che.jpg?s=1024x1024&w=gi&k=20&c=AZl4qDLGEEdWlhxzv2xe7gWW9BLYW06adV8Zm0uXOaI=", 
              facilityPhoto: "https://media.mondoconv.it/media/catalog/product/cache/9183606dc745a22d5039e6cdddceeb98/X/A/XABP_1LVL.jpg", 
              receiverName: "Giada Rossi", 
              facilityName: "Casa Dolce Casa", 
              address: "Via Roma 12", 
              lastMessage: DateTime(2024,7,1), 
              isLastChatItem: false, 
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ChatDetailPage(
                    receiverImageUrl: "https://media.gettyimages.com/id/1437816897/it/foto/ritratto-di-donna-daffari-manager-o-risorse-umane-per-il-successo-professionale-azienda-che.jpg?s=1024x1024&w=gi&k=20&c=AZl4qDLGEEdWlhxzv2xe7gWW9BLYW06adV8Zm0uXOaI=", 
                    receiverName: "Giada Rossi", 
                    facilityName: "Casa Dolce Casa", 
                    lastMessage: DateTime(2024,7,1), 
                    onTap: () => {}
                  )
                )
              )
            ),

            ChatItem(
              receiverPhoto: "https://www.fotografareperstupire.com/wp-content/uploads/2023/03/pose-per-foto-uomo-selfie.jpg", 
              facilityPhoto: "https://cdn.cosedicasa.com/wp-content/uploads/webp/2022/05/cucina-e-soggiorno-640x320.webp", 
              receiverName: "Mario Guidi", 
              facilityName: "Bella Italia", 
              address: "Via Belzoni 5", 
              lastMessage: DateTime(2024,6,28), 
              isLastChatItem: false, 
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ChatDetailPage(
                    receiverImageUrl: "https://www.fotografareperstupire.com/wp-content/uploads/2023/03/pose-per-foto-uomo-selfie.jpg", 
                    receiverName: "Mario Guidi", 
                    facilityName: "Bella Italia", 
                    lastMessage: DateTime(2024,6,28), 
                    onTap: () => {}
                  )
                )
              )
            ),

            ChatItem(
              receiverPhoto: "https://www.fotografareperstupire.com/wp-content/uploads/2023/03/pose-modello-uomo.jpg", 
              facilityPhoto: "https://www.grazia.it/content/uploads/2018/03/come-arredare-monolocale-sfruttando-centimetri-2.jpg", 
              receiverName: "Luigi Frassi", 
              facilityName: "Casa Studenti", 
              address: "Viale Luna 289", 
              lastMessage: DateTime(2024,6,25), 
              isLastChatItem: false, 
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ChatDetailPage(
                    receiverImageUrl: "https://www.fotografareperstupire.com/wp-content/uploads/2023/03/pose-modello-uomo.jpg", 
                    receiverName: "Luigi Frassi", 
                    facilityName: "Casa Studenti", 
                    lastMessage: DateTime(2024,6,25), 
                    onTap: () => {}
                  )
                )
              )
            ),

            ChatItem(
              receiverPhoto: "https://www.thewom.it/content/uploads/2022/01/Rosalind-Brewer-830x1107.jpg", 
              facilityPhoto: "https://www.fiorenzointeriordesign.com/images/galcms/850x635c50q80/galleryone/gallery-prodotto-test/zoom/img_6206_65721.jpg", 
              receiverName: "Serena Pizzoli", 
              facilityName: "Casa Studio", 
              address: "Via Vittoria 10", 
              lastMessage: DateTime(2024,6,20), 
              isLastChatItem: true, 
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ChatDetailPage(
                    receiverImageUrl: "https://www.thewom.it/content/uploads/2022/01/Rosalind-Brewer-830x1107.jpg", 
                    receiverName: "Serena Pizzoli", 
                    facilityName: "Casa Studio", 
                    lastMessage: DateTime(2024,6,20), 
                    onTap: () => {}
                  )
                )
              )
            )
          ]
        )
    );
  }
}